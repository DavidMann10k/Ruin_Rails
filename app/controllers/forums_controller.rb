class ForumsController < ApplicationController
  
  before_filter :authenticate, :only => [ :index, :new, :create, :show, :edit, :update, :destroy ]
  before_filter :admin_auth, :only => [ :index, :new, :create, :edit, :update, :destroy, :dex_up ]
  
  def new
    @division = Division.find(params[:division_id])
    @title = "#{@division.title}/Forums/new"
    @forum = Forum.new
  end

  def create
    @title = "#{Division.find(params[:division_id]).title}/Forums/new"
    @forum = Forum.new(:title => params[:forum][:title], 
                      :dex => new_forum_dex_for_div(params[:division_id]), 
                      :division_id => params[:division_id])
    @division = @forum.division
    if params[:commit] == "Cancel"
      redirect_to divisions_path
    else
      if @forum.save
        flash[:success] = "Forum, #{@forum.title} created successfully!"
        redirect_to divisions_path
      else
        flash[:error] = "Error in forum creation process!"
        render 'new'
      end
    end
  end

  def show
    @forum = Forum.find(params[:id])
    redirect_to divisinos_path unless user_has_clearance?(@forum.division.read_level)
    @topics = @forum.topics.by_updated
    @title = "#{@forum.division.title}/#{@forum.title}"
  end

  def edit
    @forum = Forum.find(params[:id])
    @title = "#{@forum.division.title}/#{@forum.title}/edit"
  end

  def update
    @forum = Forum.find(params[:id])
    @title = "#{@forum.division.title}/#{@forum.title}/edit"
    
    if params[:commit] == "Cancel"
      redirect_to forum_path(@forum.id)
    else
      if @forum.update_attributes(params[:forum])
        flash[:success] = "Forum updated successfully."
        redirect_to forum_path(@forum.id)
      else
        flash[:error] = "Forum update failed."
        redirect_to forum_path(@forum.id)
      end
    end
  end

  def destroy
    begin
      Forum.find(params[:id]).destroy
      flash[:success] = "Forum destroyed"
    rescue
      flash[:error] = "Forum destruction unsuccessful"
    ensure
      redirect_to divisions_path
    end
  end
  
  private
    def new_forum_dex_for_div(div_id)
      dex = Forum.find_all_by_division_id(div_id).count
    end

end
