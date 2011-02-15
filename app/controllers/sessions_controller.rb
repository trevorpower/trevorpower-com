class SessionsController < AdminController
  
  def create
    if (params[:password] == ENV['ADMIN_PASSWORD'])
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
