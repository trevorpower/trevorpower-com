class AdminController < ApplicationController

  protected

  def authenticate
    redirect_to (login_url) unless session[:authenticated]
  end

end
