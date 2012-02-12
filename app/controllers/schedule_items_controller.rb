class ScheduleItemsController < ApplicationController

  before_filter :authenticate, :only => [ :new, :create, :show, :edit, :update, :destroy ]

  def new
    @schedule_item = ScheduleItem.new
  end

  def create
    
    if params[:commit] == "Cancel"
      redirect_to user_path(current_user.id)
      flash[:notice] = "Schedule item canceled."
    else
      @schedule_item = ScheduleItem.new
      @schedule_item.user_id = current_user.id
      @schedule_item.day = params[:schedule_item][:day]
      @schedule_item.start_hour = params[:schedule_item][:start_hour]
      @schedule_item.duration = params[:schedule_item][:duration]
      
      if @schedule_item.save!
        redirect_to user_path(current_user.id)
      else
        flash[:notice] = "An Error occured while saving the new "
        redirect_to new_schedule_item_path
      end
    end    
  end
  
  def show
    @schedule_item = ScheduleItem.find(params[:id])
  end
  
  def destroy
    @schedule_item = ScheduleItem.find(params[:id])
    if @schedule_item.user == current_user || admin?
      @schedule_item.destroy
      flash[:notice] = "Schedule item destroyed"
    else
      flash[:error] = "Only administrators or schedule item owners may destroy schedule items."
    end
    redirect_to user_path(current_user.id)
  end
end