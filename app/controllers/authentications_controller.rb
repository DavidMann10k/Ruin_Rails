class AuthenticationsController < ApplicationController
  include AuthenticationsHelper
  
  def auth_callback
    @omniauth = request.env['omniauth.auth']
    @service_route = params[:service]
    @authhash = hash_by_service_route
    
    auth = Authentication.find_by_provider_and_uid(@authhash[:provider], @authhash[:uid])
    
    if signed_in?
      if auth
        flash[:error] = "Authentication has already been associated with this accout"
        redirect_to root_path
      else
        current_user.authentications.create!(:provider => @authhash[:provider], :uid => @authhash[:uid], :uname => @authhash[:name], :uemail => @authhash[:email])
        flash[:notice] = "Authentication successfully associated with this account."
        redirect_to :action => 'users', :action => 'show', :id => auth.user_id
      end
    else
      if auth
        # existing user - sign in - sessions#new
        create_session(auth)
        flash[:notice] = "You've signed in as #{current_user.name}."
        redirect_back_or auth.user
      else
        # new user - register - users#new
        flash[:notice] = "New authentication detected.  Continue to create new account."
        redirect_to :controller => "users", :action => "new", :name     => @authhash[:name], 
                                                              :email    => @authhash[:email],
                                                              :uid      => @authhash[:uid],
                                                              :provider => @authhash[:provider],
                                                              :uname    => @authhash[:name],
                                                              :uemail   => @authhash[:email]
      end
    end
  end

  def destroy
    # remove an authentication service linked to the current user
    @authentication = current_user.services.find(params[:id])
    
    if session[:authentication_id] == @authentication.id
      flash[:error] = 'You cannot remove the current authentication!'
    else
      @authentication.destroy
    end
    
    redirect_to services_path
  end

  def failure
    flash[:error] = "Authentication with your chosen provider has failed!  Try again or choose another."
    redirect_to "/authenticate"
  end

  
  def signout
    if current_user
      session[:user_id] = nil
      session[:service_id] = nil
      session.delete :user_id
      session.delete :service_id
      flash[:notice] = 'You have been signed out!'
    end  
    redirect_to root_url
  end
  
  def authenticate
    @title = "authenticate"
  end
end
