class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :require_login

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  private

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path
    end
  end

  def logged_in?
    !current_user.nil?
  end
end
