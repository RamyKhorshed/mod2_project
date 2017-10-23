class UsersController < ApplicationController

  def index

  end

  def new

  end

  def create

  end

  def show
    @user = User.find_by(id: params[:id])
    @public_achievements = Achievement.all
  end

  def edit
    
  end

  def update

  end

  private
  def user_params
    params.require(:user).permit(:name, :password, :quote)
  end

end
