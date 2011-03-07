class ContactController < ApplicationController
  def index
    if (params[:message].nil?)
      @message = Message.new :id => 1
    else
      @message = Message.new params[:message]
      if (@message.valid?)
        ContactMailer.contact_email(@message).deliver
        flash[:notice] = 'Message sent successfully'
        @message = Message.new :id => 1
      end
    end
  end
end
