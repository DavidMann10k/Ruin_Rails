class AvailabilitiesController < ApplicationController
  # GET /availabilities
  # GET /availabilities.json
  def index
    @title = "availabilities"
    @availabilities = Availability.order("begin asc")
    
    date = DateTime.now.in_time_zone(current_user.time_zone)
     
    @sun_num = @availabilities.where(:begin => date...(date+1.day)).size + @availabilities.where(:begin => (date+7.day)...(date+8.day)).size
    @mon_num = @availabilities.where(:begin => (date.+1.day)...(date+2.day)).size
    @tue_num = @availabilities.where(:begin => (date+2.day)...(date+3.day)).size
    @wed_num = @availabilities.where(:begin => (date+3.day)...(date+4.day)).size
    @thu_num = @availabilities.where(:begin => (date+4.day)...(date+5.day)).size
    @fri_num = @availabilities.where(:begin => (date+5.day)...(date+6.day)).size
    @sat_num = @availabilities.where(:begin => (date+6.day)...(date+7.day)).size + @availabilities.where(:begin => (date-1.day)...date).size

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @availabilities }
    end
  end

  # GET /availabilities/1
  # GET /availabilities/1.json
  def show
    @availability = Availability.find(params[:id])
    @title = "availability/#{@availability.user.name} "

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @availability }
    end
  end

  # GET /availabilities/new
  # GET /availabilities/new.json
  def new
    
    @title = "availabilities/new"
    @availability = Availability.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @availability }
    end
  end

  # GET /availabilities/1/edit
  def edit
    @availability = Availability.find(params[:id])
    @title = "availabilities/edit"
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
        format.html { redirect_to @availability.user, notice: 'Availability was successfully created.' }
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
    
    @availability.update_attributes(params[:availability])
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
    @user = @availability.user
    redirect_to availabilities_path unless @availability.user == current_user || admin?
    @availability.destroy

    respond_to do |format|
      format.html { redirect_to @user }
      format.json { head :ok }
    end
  end
end
