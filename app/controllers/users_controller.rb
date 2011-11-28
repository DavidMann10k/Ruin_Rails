class UsersController < ApplicationController
  before_filter :not_signed_in, :only => [:new, :create]
  
  def fake_name
    Faker::Name.name
  end
  
  def index
    @title = "users"
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
      if @user.save
        auth = @user.authentications.create!(:provider => params[:provider],
                                      :uid      => params[:uid],
                                      :uname    => params[:uname],
                                      :uemail   => params[:uemail])
                                      
        session[:user_id] = @user.id
        session[:authentication_id] = auth.id
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
    @user = User.find(params[:id])
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
  end
  
end
