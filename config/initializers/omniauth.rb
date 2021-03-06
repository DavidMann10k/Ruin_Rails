Rails.application.config.middleware.use OmniAuth::Builder do
   # ALWAYS RESTART YOUR SERVER IF YOU MAKE CHANGES TO THESE SETTINGS!
   
   require 'openid/store/filesystem'
   
   provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => 'open_id'
   provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
   provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => 'yahoo', :identifier => 'yahoo.com' 
   provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => 'myopenid', :identifier => 'myopenid.com'
   provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => 'aol', :identifier => 'openid.aol.com'
   provider :facebook, '205256926221597', 'b89e38cb979ca36da8389d2b165b1bb9'
   provider :twitter, 'PVpMXvTFSzYRiuYHRunyIA', 'pUu00u4WC5EUTTHoNRLdHZgGU5wIB1dVpTEIBOGbhEM'
end