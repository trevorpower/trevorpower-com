class ContactController < ApplicationController
  def index
    if (params[:message].nil?)
      @message = Message.new
    else
      @message = Message.new params[:message]
      if (@message.valid?)
        Emailer::deliver_contact_email(@message)
      end
    end
  end
  def send_mail
    Emailer::deliver_contact_email(params[:email])
  end
end
