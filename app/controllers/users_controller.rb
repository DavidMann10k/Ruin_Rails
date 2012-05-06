class UsersController < ApplicationController
  before_filter :not_signed_in, :only => [:new, :create]
  before_filter :admin_auth, :only => [ :promote, :demote ]
  
  def fake_name
    Faker::Name.name
  end
  
  def index
    @title = "users"
    @users = User.by_name
  end
  
  def new
    @title = "register"
    @user = User.new
    @user.name = params[:name]
    @user.email = params[:email]
  end
  
  def create
    if params[:commit] == "Cancel"
      session[:authhash] = nil
      session.delete :authhash
      redirect_to root_url
      flash[:notice] = "Registration Aborted."
    else
        
      @user = User.new(params[:user])
      @user.rank = Rank.find_by_title("Registered")
      if @user.save
        auth = @user.authentications.create!(:provider => params[:provider],
                                      :uid      => params[:uid],
                                      :uname    => params[:uname],
                                      :uemail   => params[:uemail])
        create_session(auth)
        flash[:success] = "Account created successfully!"
        #redirect_to @user
        redirect_to :action => "show", :controller => "users", :id => auth.user.id
      else
        flash[:error] = "There were problems during registration.  Account not created!"
        render 'new'
      end
    end
  end
  
  def edit
    if admin?
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    @title = "users/#{@user.name}/edit"
  end
  
  def update
    @user = User.find(params[:id])
    
    if params[:commit] == "Cancel"
        flash[:notice] = "User update canceled."
    else
      if @user.update_attributes(params[:user])
        flash[:success] = "User updated successfully."
      else
        flash[:error] = "User update failed."
      end
    end
      redirect_to user_path(@user.id)
  end
  
  def not_signed_in
    unless !signed_in?
      flash[:error] = "You are already authenticated and registered!  Log out if you wish to register another acount."
      redirect_to root_path
    end
    
  end
    
  def show
    @user = User.find(params[:id])
    @title = User.find(params[:id]).name
    @availabilities = Availability.for_user(@user).by_begin
  end
  
  def promote
    @user = User.find(params[:id])
    if @rank = Rank.find_by_clearance(@user.rank.clearance + 1)
      @user.rank = @rank
      @user.save
    else
      flash[:error] = "Cannot promote any further"
    end
    redirect_to users_path
  end
  
  def demote
    @user = User.find(params[:id])
    if @rank = Rank.find_by_clearance(@user.rank.clearance - 1)
      @user.rank = @rank
      @user.save
    else
      flash[:error] = "Cannot demote any further!"
    end
    redirect_to users_path
  end
end
