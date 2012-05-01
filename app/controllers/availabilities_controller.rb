class AvailabilitiesController < ApplicationController
  # GET /availabilities
  # GET /availabilities.json
  def index
    @availabilities = Availability.order("begin asc")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @availabilities }
    end
  end

  # GET /availabilities/1
  # GET /availabilities/1.json
  def show
    @availability = Availability.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @availability }
    end
  end

  # GET /availabilities/new
  # GET /availabilities/new.json
  def new
    @availability = Availability.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @availability }
    end
  end

  # GET /availabilities/1/edit
  def edit
    @availability = Availability.find(params[:id])
    redirect_to availabilities_path unless @availability.user == current_user || admin?
  end

  # POST /availabilities
  # POST /availabilities.json
  def create
    @availability = Availability.new(params[:availability])
    @availability.user= current_user
    

    @availability.begin = @availability.begin.change(:day => params[:availability][:begin], :month => 4, :year => 2012)
    @availability.end = @availability.end.change(:day => params[:availability][:end], :month => 4, :year => 2012)

    respond_to do |format|
      if @availability.save
        format.html { redirect_to @availability, notice: 'Availability was successfully created.' }
        format.json { render json: @availability, status: :created, location: @availability }
      else
        format.html { render action: "new" }
        format.json { render json: @availability.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /availabilities/1
  # PUT /availabilities/1.json
  def update
    @availability = Availability.find(params[:id])
    
    redirect_to availabilities_path unless @availability.user == current_user || admin?
    
    @availability.begin = @availability.begin.change(:day => params[:availability][:begin])
    @availability.end = @availability.end.change(:day => params[:availability][:end])
    
    if @availability.save
      redirect_to @availability, notice: 'Availability was successfully updated.'
    else
      render action: "edit"
      render json: @availability.errors, status: :unprocessable_entity
    end
  end

  # DELETE /availabilities/1
  # DELETE /availabilities/1.json
  def destroy
    @availability = Availability.find(params[:id])
    redirect_to availabilities_path unless @availability.user == current_user || admin?
    @availability.destroy

    respond_to do |format|
      format.html { redirect_to availabilities_url }
      format.json { head :ok }
    end
  end
end
