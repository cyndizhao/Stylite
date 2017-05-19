class UsersController < ApplicationController
  before_action :get_user, only:[:show, :edit, :update]
  before_action :authenticate_user!, only:[:update, :edit, :show]
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Thank you for signing in"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user_id = params[:id]
    @user = User.find_by_id(@user_id)
    @posts = @user.posts
    # session[:user_id]
  end

  def edit

  end

  def update
    # TODO add if else
    if @user.update(params.require(:user).permit([:first_name, :last_name, :company_name, :email, :description, :selfie]))
      flash[:notice] = "User Infomation Updated"
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  private
  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit([:first_name, :last_name, :email, :description, :password, :password_confirmation, :selfie, :business_user, :company_name])
  end
end
