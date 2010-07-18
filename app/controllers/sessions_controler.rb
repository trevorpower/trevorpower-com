class SessionsController < ApplicationController
  def destroy
    reset_session
    flash[:notice] = 'Successfully logged out'
    redirect_to home_path
  end
end
