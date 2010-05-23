class Emailer < ActionMailer::Base
  def contact_email(email_params)
        # You only need to customize @recipients.
        @recipients = "contact@trevorpower.com"
        @from = email_params[:name] + " <" + email_params[:address] + ">"
        @subject = "via trevorpower.com"
        @sent_on = Time.now
        @body["email_body"] = email_params[:body]
        @body["email_name"] = email_params[:name]
        content_type "text/html"
    end
end
