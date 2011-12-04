class DivisionsController < ApplicationController
  
  before_filter :authenticate, :only => [ :index, :new, :create, :show, :edit, :update, :destroy, :dex_up ]
  before_filter :admin_auth, :only => [ :new, :create, :edit, :update, :destroy, :dex_up ]
  
  def index
    @divisions = Division.order("dex ASC").all.select { |d| user_has_clearance?(d.read_level) }
    @title = "Divisions"
  end

  def new
    @title = "Divisions/new"
    @division = Division.new
  end

  def create
    @title = "Divisions/new"
    @division = Division.new(:title => params[:division][:title], :dex => new_division_dex)
    
    if params[:commit] == "Cancel"
        redirect_to divisions_path
    else
      if @division.save
        redirect_to divisions_path
      else
        render 'new'
      end
    end
      
  end

  def show
    div = Division.find(params[:id])
    @division = div if user_has_clearance?(div.read_level)
    @title = "Divisions/#{@division.title}"
  end

  def edit
    @division = Division.find(params[:id])
    @title = "Divisions/#{@division.title}/edit"
  end

  def update
    @division = Division.find(params[:id])
    
    if params[:commit] == "Cancel"
      redirect_to division_path(@division.id)
    else
      if @division.update_attributes(params[:division])
        flash[:success] = "Division updated successfully."
        redirect_to division_path(@division.id)
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
  
  private
    def new_division_dex
        dex = Division.count
    end
end
