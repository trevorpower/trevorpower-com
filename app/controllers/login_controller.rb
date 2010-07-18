class LoginController < ApplicationController
  
  def index

  end

  def login
    if (params[:password] == 'password1')
      flash[:notice] = 'Successfully logged in'
      session[:authenticated] = true;
      redirect_to posts_path
    else
      flash[:notie] = 'Password is incorrect'
      redirect_to login_path
    end

    
  end

end
