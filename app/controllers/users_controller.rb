class UsersController < ApplicationController

  def index

  end

  def new
    @user = User.new
  end

  def create

  end

  def show
    @user = User.find_by(id: params[:id])
    @public_achievements = Achievement.all
  end

  def edit

    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.update(user_params)
    if @user.save
      redirect_to "/users/#{@user.id}"
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :password, :quote)
  end

end
