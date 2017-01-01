begin
  PROGNAME.nil?
rescue NameError => e
  PROGNAME = File.basename(__FILE__)
end

require 'methadone'
require 'mail'
require "simplemailer/version"

module SimpleMailer
  
  include Methadone::CLILogging

  module_function

  def run(options)
    logger.level = Logger::DEBUG if options[:debug] && !logger.debug?

    debug "#{PROGNAME}@#{__LINE__} in #{self.class}##{__method__}: options: #{options.to_yaml}"

    mail = Mail.new()
    mail[:from] = options[:from]
    mail[:to] = options[:to].join(",")
    mail[:subject] = options[:subject] ||= '<no subject>'
    mail['X-Mailer'] = "#{PROGNAME} #{SimpleMailer::VERSION}"
    
    if options[:body]
      mail[:body] = options[:body]
    else
      mail[:body] = STDIN.read
    end
    if options[:transport]
      mail.delivery_method :sendmail, :location => options[:transport]
    end

    
    debug "#{PROGNAME}@#{__LINE__} in #{self.class}##{__method__}: mail: #{mail}"
    mail.deliver unless options[:debug]
    
  end

end
