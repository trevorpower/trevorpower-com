require 'bcrypt'

class SessionsController < AdminController
  
  def create
    hash = BCrypt::Engine.hash_secret(params[:password], ENV['ADMIN_PASSWORD_SALT'])
    if (hash == ENV['ADMIN_PASSWORD_HASH'])
      flash[:notice] = 'Successfully logged in'
      session[:authenticated] = true;
      redirect_to posts_path
    else
      flash[:notice] = 'Password is incorrect'
      redirect_to login_url
    end
  end

  def destroy
    reset_session
    flash[:notice] = 'Successfully logged out'
    redirect_to home_path
  end
end
