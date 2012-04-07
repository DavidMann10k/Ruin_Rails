class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user, :signed_in?, :admin?, :user_has_clearance?, :new_content?
  before_filter :touch_user

  def admin?
    current_user.admin
  end
  
  def signed_in?
    !current_user.nil?
  end
 
  def current_user
    @current_user ||= user_from_session
  end
  
  def current_user?(user)
    current_user == user
  end
  
  def current_user_or_admin?(user)
    current_user?(user) || admin?
  end
  
  def authenticate
    deny_access unless signed_in?
  end
  
  def deny_access
    store_location
    redirect_to authenticate_path, :notice => "Please sign for this action."
  end
  
  def admin_auth
    block_action unless admin?
  end
  
  def block_action
    redirect_to root_path, :notice => "Not authorized for this action."
  end

  def user_has_clearance?(level)
    current_user.rank.clearance >= level.to_i
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end
  
  def create_session(auth)
      session[:user_id] = auth.user.id
      session[:authentication_id] = auth.id
      current_user.update_attribute(:last_login, current_user.updated_at)
  end
  
  def new_content?(datetime)
    datetime > current_user.last_login.to_datetime
  end
  private
    def user_from_session
      User.find_by_id(session[:user_id]) if session[:user_id]
    end
    
    def store_location
      session[:return_to] = request.fullpath
    end
    
    def clear_return_to
      session[:return_to] = nil
    end    
    
    def touch_user
      begin
        current_user.touch
      rescue
      end
    end
end
