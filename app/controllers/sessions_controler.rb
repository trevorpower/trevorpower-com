class SessionsController < ApplicationController
  
  def create
    if (params[:password] == 'password1')
      flash[:notice] = 'Successfully logged in'
      session[:authenticated] = true;
      redirect_to posts_path
    else
      flash[:notie] = 'Password is incorrect'
      redirect_to login_url
    end
  end

  def destroy
    reset_session
    flash[:notice] = 'Successfully logged out'
    redirect_to home_path
  end
end
