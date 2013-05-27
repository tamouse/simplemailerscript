=begin rdoc

= RUN_SPEC.RB

*Author*::      Tamara Temple <tamara@tamaratemple.com>
*Since*::       2013-05-27
*Copyright*::   (c) 2013 Tamara Temple Web Development
*License*::     MIT
  
=end

require 'spec_helper.rb'

module SimpleMailer

  include Methadone::CLILogging
  logger.level = Logger::DEBUG
  
  Mail.defaults do
    delivery_method :test
  end


  describe "SimpleMailer" do
    it {SimpleMailer.should respond_to(:run)}
    describe "#run" do
      include Mail::Matchers
      let(:recipients) {["tamouse@example.com", "another_mouse@example.com", "and_another@example.com"]}
      let(:options) {
        {:to => recipients,
          :from => "sending_mouse@example.net",
          :subject => "Test subject",
          :body => "Test body for #{example.description}.\n\nHello, World!\n",
        }
      }
      before(:each) do
        Mail::TestMailer.deliveries.clear
        SimpleMailer.run(options)
      end
      it {should have_sent_email}
      it {should have_sent_email.from "sending_mouse@example.net"}
      it {should have_sent_email.to(recipients) }
    end
  end

end
