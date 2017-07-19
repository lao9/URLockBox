class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def authenticate_user
    unless current_user
      flash[:alert] = "Please login to continue!"
      redirect_to login_path
    end
  end

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
