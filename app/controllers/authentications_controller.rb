class AuthenticationsController < ApplicationController
  
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
        session[:user_id] = auth.user.id
        session[:authentication_id] = auth.id
        flash[:notice] = "You've signed in as #{current_user.name}."
        redirect_to :action => "show", :controller => "users", :id => auth.user.id
      else
        # new user - register - users#new
        flash[:notice] = "Not signed in, no authentication"
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
    flash[:error] = "Authentication with your chosen provider has failed!  Try again or chose another."
    redirect_to "/authenticate"
  end

  def hash_by_service_route
      authhash = Hash.new
      if @service_route == 'facebook'
        @omniauth['extra']['user_hash']['email'] ? authhash[:email] =  @omniauth['extra']['user_hash']['email'] : authhash[:email] = ''
        @omniauth['extra']['user_hash']['name'] ? authhash[:name] =  @omniauth['extra']['user_hash']['name'] : authhash[:name] = ''
        @omniauth['extra']['user_hash']['id'] ?  authhash[:uid] =  @omniauth['extra']['user_hash']['id'].to_s : authhash[:uid] = ''
        @omniauth['provider'] ? authhash[:provider] = @omniauth['provider'] : authhash[:provider] = ''
      elsif @service_route == 'github'
        @omniauth['user_info']['email'] ? authhash[:email] =  @omniauth['user_info']['email'] : authhash[:email] = ''
        @omniauth['user_info']['name'] ? authhash[:name] =  @omniauth['user_info']['name'] : authhash[:name] = ''
        @omniauth['extra']['user_hash']['id'] ? authhash[:uid] =  @omniauth['extra']['user_hash']['id'].to_s : authhash[:uid] = ''
        @omniauth['provider'] ? authhash[:provider] =  @omniauth['provider'] : authhash[:provider] = ''  
      elsif ['google', 'yahoo', 'twitter', 'myopenid', 'open_id'].index(@service_route) != nil
        @omniauth['user_info']['email'] ? authhash[:email] =  @omniauth['user_info']['email'] : authhash[:email] = ''
        @omniauth['user_info']['name'] ? authhash[:name] =  @omniauth['user_info']['name'] : authhash[:name] = ''
        @omniauth['uid'] ? authhash[:uid] = @omniauth['uid'].to_s : authhash[:uid] = ''
        @omniauth['provider'] ? authhash[:provider] = @omniauth['provider'] : authhash[:provider] = ''
      else        
        # debug to output the hash that has been returned when adding new services
        render :text => @omniauth.to_yaml
        return
      end
      return authhash
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
