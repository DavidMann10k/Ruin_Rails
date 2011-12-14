class PostsController < ApplicationController
  
  before_filter :authenticate, :only => [ :index, :new, :create, :show, :edit, :update, :destroy ]
  before_filter :admin_auth, :only => [ :destroy ]
  before_filter :admin_or_user_auth => [ :toggle_publish ]
  def new
    @post = Post.new
    @topic = Topic.find(params[:topic_id])
    @title = "#{@topic.forum.division.title}/#{@topic.forum.title}/#{@topic.title}/Posts/new"
    return redirect_to topic_path(@topic.id) unless user_has_clearance?(@topic.forum.division.write_level)
  end
  
  def create
    @topic = Topic.find(params[:topic_id])
    return redirect_to divisions_path unless user_has_clearance?(@topic.forum.division.read_level)
    @title = "#{@topic.forum.division.title}/#{@topic.forum.title}/#{@topic.title}/Posts/new"
    if params[:commit] == "Cancel"
      redirect_to :controller => "topics", :action => "show", :id => @topic.id
    else
      @post = Post.new
      @post.content = params[:post][:content]                    
      @post.topic_id = params[:topic_id]
      @post.user_id = current_user.id
      @post.toggle(:publish)
      
      if @post.save
        @post.topic.touch
        @post.topic.forum.touch
        @post.topic.forum.division.touch
        flash[:success] = "New post created successfully!"
        redirect_to topic_path(@post.topic_id)
      else
        flash[:error] = "Error in post creation process!"
        render 'new'
      end
    end
  end
  
  def show
    @post = Post.find(params[:id])
    return redirect_to divisions_path unless user_has_clearance?(@post.topic.forum.division.read_level)
    @title = "#{@post.topic.forum.division.title}/#{@post.topic.forum.title}/#{@post.topic.title}/post by #{@post.user.name}}" 
  end

  def edit
    @post = Post.find(params[:id])
    return redirect_to divisions_path unless user_has_clearance?(@post.topic.forum.division.write_level)
    @title = "#{@post.topic.forum.division.title}/#{@post.topic.forum.title}/#{@post.topic.title}/Post:#{@post.created_at}/edit"
  end
  
  def update
    @post = Post.find(params[:id])
    return redirect_to divisions_path unless user_has_clearance?(@post.topic.forum.division.write_level)
    new_post = duplicate_post(@post)
    
    if params[:commit] == "Cancel"
      redirect_to topic_path(@post.topic_id)
    else
      @post.publish = false
      @post.save
      
      if new_post.update_attributes(params[:post])
        flash[:success] = "Post updated successfully."
      else
        flash[:error] = "Post update failed."
      end
    end
      redirect_to topic_path(@post.topic_id)    
  end
  
  def destroy
    begin
      @post = Post.find(params[:id])
      topic_id = @post.topic_id
      @post.destroy
      flash[:success] = "Post destroyed"
    rescue
      flash[:error] = "Post destruction unsuccessful"
    ensure
      redirect_to topic_path, :id => topic_id
    end    
  end
  
  def toggle_publish
    @post = Post.find(params[:id])
    if (current_user == @post.user) || admin?
      @post.toggle(:publish).save
    end
    redirect_to topic_path(@post.topic)
  end
  
  private
    
    def duplicate_post(post)
      new_post = post.dup
      new_post.created_at = post.created_at
      new_post
    end
end
