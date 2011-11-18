require 'spec_helper'

describe Authentication do
  
  before(:each) do
    @auth = Authentication.new
    @auth.user_id = 1
    @auth.provider = "google"
    @auth.uid = "sample.google.com"
    @auth.uname = "Example User"
    @auth.uemail = "example@user.com"
  end
  
  describe "should require value for" do
    
    it "user_id" do
      @auth.user_id = nil
      @auth.should_not be_valid
    end
    
    it "provider" do
      @auth.provider = ""
      @auth.should_not be_valid
    end
    
    it "uid" do
      @auth.uid = ""
      @auth.should_not be_valid
    end
  end
  
  describe "user_id" do
    it "should reject non-integer value" do
      @auth.user_id = "A"
      @auth.should_not be_valid
    end
  end
end
