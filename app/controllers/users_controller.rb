class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  before_action :already_logged_in?, only:[:new,:create]

  def index
    @users = User.all
  end

  def new
  end

  def create
    binding.pry
    @user = User.new(user_params)
      if @user.save && params[:password] == params[:password_confirmation] #should be user_params both times??
        binding.pry
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        binding.pry
        redirect_to controller: 'users', action: 'new'
      end
   end


   def show
     find_user
     @public_achievements = find_user.achievements
     @all_bucketlist = find_user.bucketlists
     @all_activities = find_user.activities
     @bucketlist = Bucketlist.new
   end

  def edit
    find_user
  end

  def update
    find_user
    @user.update(user_params)
    if @user.save
      redirect_to "/users/#{@user.id}"
    else
      render :edit
    end
  end

  def destroy
    find_user.destroy
    redirect_to '/'
  end

  private
  def user_params
   params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
  end
  def find_user
    @user = User.find_by(id: params[:id])
  end

end
