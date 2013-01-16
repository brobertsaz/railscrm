class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_current_user

  def after_sign_in_path_for(resource)
    dashboard_path
  end
 
private
  def set_current_user
    return true unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end
 
  def require_user
    redirect_to new_user_path unless session[:user_id]
    set_current_user
  end

end
