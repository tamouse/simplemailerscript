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

    unless options[:transport].nil?
      options[:transport].tap do |transport|
        Mail.defaults do
          case transport
          when :smtp
            delivery_method :smtp, transport['options']
          when :exim
            delivery_method :exim, :location => transport['location']
          when :sendmail
            delivery_method :sendmail, :location => transport['location']
          end
        end
      end
    end

    Mail.deliver do |mail|
      mail[:from] = options[:from]
      mail[:to] = options[:to].join(",")
      mail[:subject] = options[:subject] ||= '<no subject>'
      mail['X-Mailer'] = "#{PROGNAME} #{SimpleMailer::VERSION}"
      if options[:body]
        mail[:body] = options[:body]
      else
        mail[:body] = STDIN.read
      end
      debug "#{PROGNAME}@#{__LINE__} in #{self.class}##{__method__}: mail: #{mail}"
    end
    
  end

end
