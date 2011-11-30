require 'spec_helper'

describe PostsController do
  render_views
  
  before(:each) do
    @user = FactoryGirl.create :user
    @division = FactoryGirl.create :division
    @forum = FactoryGirl.create :forum, :division_id => @division.id
    @topic = FactoryGirl.create :topic, :forum_id => @forum.id, :user_id => @user.id
    @post = FactoryGirl.create :post, :topic_id => @topic.id, :user_id => @user.id
  end
  
  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get :edit, :id => @post.id
      response.should be_success
    end
  end

end
