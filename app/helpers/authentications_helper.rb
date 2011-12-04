module AuthenticationsHelper

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
      elsif ['aol', 'google', 'yahoo', 'twitter', 'myopenid', 'open_id'].index(@service_route) != nil
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
end