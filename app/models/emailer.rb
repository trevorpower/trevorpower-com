class Emailer < ActionMailer::Base

  def contact_email(contact)
    @recipients = "contact@trevorpower.com"
    @from = contact.name + " <" + contact.address + ">"
    @subject = "[via trevorpower.com]" + contact.subject
    @sent_on = Time.now
    @body["email_body"] = contact.body
    @body["email_name"] = contact.name
    content_type "text/html"
  end
  
end
