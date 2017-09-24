class UsersController < ApplicationController
  before_action :signed_in_user, only:[:edit, :update]
  before_action :correct_user, only:[:edit, :update]
  before_action :admin_user, only: [:destroy]

  def new
  	@user = User.new
  end
  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  def create 
  	@user = User.new(user_params)
  	if @user.save
  		flash[:success] = 'Welcome to the Sample App!'
  		redirect_to @user
  	else
  		render 'new'
  	end
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Your setting update success'
      redirect_to @user
    else
      render 'edit'
    end
  end
  def index
    @users = User.all.paginate(:page => params[:page], :per_page => 10)
  end
  def delete
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end
  private
  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end
    def correct_user
      @user = User.find(params[:id])
      unless is_current_user(@user)
        redirect_to root_url
      end
    end
    def admin_user
      unless correct_user.admin?
        redirect_to root_url
      end
    end	
end
