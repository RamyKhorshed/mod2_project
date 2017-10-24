class UsersController < ApplicationController

  def index

  end

  def new
  end

  def create
     @user = User.create(user_params)
     return redirect_to controller: 'users', action: 'new' unless @user.save
     session[:user_id] = @user.id
     redirect_to user_path(@user)
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
   params.require(:user).permit(:name, :password, :password_confirmation)
 end

end
