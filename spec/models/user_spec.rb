require 'spec_helper'

describe User do
  
  before(:each) do
    @user = FactoryGirl.build(:user)
  end

  it "should require a name" do
    @user.name = ""
    @user.should_not be_valid
  end
  
  it "should require an email" do
    @user.email = ""
    @user.should_not be_valid
  end
  
  it "should reject names that are too long" do
    @user.name = ("A"*51)
    @user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      @user.email = address
      @user.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      @user.email = address
      @user.should_not be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
    user = User.create(:name => "email user", :email => "valid.email@email.com")
    duplicate_user = User.new(:name => "email user", :email => "valid.email@email.com")
    
    duplicate_user.should_not be_valid
    user.destroy
  end
  
  it "should reject email addresses identical up to case" do
    user = User.create(:name => "email user", :email => "valid.email@email.com".upcase)
    duplicate_user = User.new(:name => "email user", :email => "valid.email@email.com")
    
    duplicate_user.should_not be_valid
    user.destroy
  end
  
  describe "admin attribute" do
    
    it "should respond to admin" do
      @user.should respond_to(:admin)
    end
    
    it "should not be an admin by default" do
      @user.should_not be_admin
    end
    
    it "should be convertible to an admin" do
      @user.toggle!(:admin)
      @user.should be_admin
      @user.destroy
    end
  end
end