class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update]

  def index
  end

  def show
  end

  def new
    @user = User.new
  end

  def create

    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Successfully registered."
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end

  end

  def edit

    
  end

  def update

    if @user.update(user_params)
      flash[:notice] = "Successfully updated user."
      redirect_to edit_user_path(@user)
    else
      render :edit
    end

  end

  private

  def set_user
    @user = User.find_by(slug: params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :time_zone)
  end

end