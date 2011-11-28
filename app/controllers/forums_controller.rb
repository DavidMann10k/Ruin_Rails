class ForumsController < ApplicationController
  def new
    @division_id = params[:division_id]
    @title = "Forums/new"
    @forum = Forum.new
  end

  def create
    if params[:commit] == "Cancel"
      redirect_to divisions_path
    else
      @forum = Forum.new(:title => params[:forum][:title], 
                        :dex => new_forum_dex_for_div(params[:division_id]), 
                        :division_id => params[:division_id])
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
    @title = @forum.title
  end

  def edit
    @forum = Forum.find(params[:id])
  end

  def update
    @forum = Forum.find(params[:id])
    
    if params[:commit] == "Cancel"
      redirect_to forum_path(@forum.id)
    else
      if @forum.update_attributes(params[:forum])
        flash[:success] = "Forum updated successfully."
      else
        flash[:error] = "Forum update failed."
      end
    end
      redirect_to forum_path(@forum.id)
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
  
  def new_forum_dex_for_div(div_id)
    dex = Forum.find_all_by_division_id(div_id).count
  end

end
