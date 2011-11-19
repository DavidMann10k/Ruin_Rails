class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user, :signed_in?
  
  def signed_in?
    !current_user.nil?
  end
 
  def current_user
    @current_user ||= user_from_session
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def authenticate
    deny_access unless signed_in?
  end
  
  def deny_access
    store_location
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end
  
  private
    def user_from_session
      User.find_by_id(session[:user_id]) if session[:user_id]
    end
end
