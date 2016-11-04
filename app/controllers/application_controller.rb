class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def is_admin?
    current_user && current_user.admin === true
  end
  helper_method :is_admin?

  def authorize
    redirect_to new_session_path unless current_user
  end
end
