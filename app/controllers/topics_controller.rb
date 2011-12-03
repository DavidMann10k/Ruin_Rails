class TopicsController < ApplicationController
  before_filter :authenticate, :only => [ :index, :new, :create, :show, :edit, :update, :destroy ]
  before_filter :admin_auth, :only => [ :destroy ]
  
  def new
    @topic = Topic.new
    @forum = Forum.find params[:forum_id]
    @title = "#{@forum.division.title}/#{@forum.title}/Topics/new"
  end
  
  def create
      @topic = Topic.new(:title     => params[:topic][:title],                    
                         :forum_id  => params[:forum_id])
      @topic.user_id = current_user.id
      
    if params[:commit] == "Cancel"
      redirect_to forum_path, id => params[:forum_id]
    else
      
      if @topic.save
        flash[:success] = "Topic, #{@topic.title} created successfully!"
        redirect_to :controller => "topics", :action => "show", :id => @topic.id
      else
        flash[:error] = "Error in topics creation process!"
        render 'new'
      end
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts.order("created_at ASC, updated_at DESC").select {|p| publish_post(p) }
    @title = "#{@topic.forum.division.title}/#{@topic.forum.title}/#{@topic.title}"
  end

  def edit
    @topic = Topic.find(params[:id])
    @title = "#{@topic.forum.division.title}/#{@topic.forum.title}/#{@topic.title}/edit"
  end

  def update
    @topic = Topic.find(params[:id])
    
    if params[:commit] == "Cancel"
      redirect_to forum_path(@topic.forum_id)
    else
      if @topic.update_attributes(params[:topic])
        flash[:success] = "Topic updated successfully."
      else
        flash[:error] = "Tpoic update failed."
      end
    end
      redirect_to forum_path(@topic.forum_id)
  end
  

  def destroy
    begin
      @topic = Topic.find(params[:id])
      forum_id = @topic.forum_id
      @topic.destroy
      flash[:success] = "Topic destroyed"
    rescue
      flash[:error] = "Topic destruction unsuccessful"
    ensure
      redirect_to forum_path, :id => forum_id
    end
  end
  
  def publish_post(post)
    return true if post.publish
    return true if admin?
    return true if post.user == current_user
    return false
  end
end
