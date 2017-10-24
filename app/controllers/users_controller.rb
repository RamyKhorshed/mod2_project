class UsersController < ApplicationController

  def index

  end

  def new
      @user = User.new
  end

  def create
    if User.new(user_params).valid?
        flash[:success] = "Welcome to the Sample App!"
        binding.pry
        @user = User.create(user_params)
        redirect_to user_path(@user)
    else
        @user = User.new(name:params[:user][:name])
        @users = User.all
        render :new
    end
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
