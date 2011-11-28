class DivisionsController < ApplicationController
  
  def index
    @divisions = Division.order("dex ASC").all
    @title = "Divisions"
  end

  def new
    @title = "Divisions/new"
    @division = Division.new
  end

  def create
    if params[:commit] == "Cancel"
    
    else
      @division = Division.new(:title => params[:division][:title], :dex => new_division_dex)
      if @division.save
        redirect_to divisions_path
      else
        render 'new'
      end
    end
      
  end

  def show
    @division = Division.find(params[:id])
    @title = @division.title
  end

  def edit
    @division = Division.find(params[:id])
  end

  def update
    @division = Division.find(params[:id])
    
    if params[:commit] == "Cancel"
      redirect_to divisions_path(@division.id)
    else
      if @division.update_attributes(params[:division])
        flash[:success] = "Division updated successfully."
        redirect_to divisions_path
      else
        flash[:error] = "Division update failed."
        render 'edit'
      end
    end
  end

  def destroy
    begin
      Division.find(params[:id]).destroy
      flash[:success] = "Division destroyed"
    rescue
      flash[:error] = "Division destruction unsuccessful"
    ensure
      redirect_to divisions_path
    end
  end
  
  def dex_up
    div = Division.find(params[:id])
    div.swap_dex_with(Division.find_by_dex(div.dex-1)) if div.dex > 0
    redirect_to divisions_path
  end
  
  def new_division_dex
      dex = Division.count
  end
end
