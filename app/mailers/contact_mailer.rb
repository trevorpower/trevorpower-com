class ContactMailer < ActionMailer::Base
  default :to => "email@trevorpower.com"
  
  def contact_email(message)
    @body = message.body
    @name = message.name
    mail(:from => "#{message.name} <#{message.address}>",
         :subject => "[via trevorpower.com] #{message.subject}") 
  end
end
