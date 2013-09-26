class UsersController < ApplicationController

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
      redirect_to root_path
    else
      render :new
    end

  end

  def edit

  end

  def update

  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end