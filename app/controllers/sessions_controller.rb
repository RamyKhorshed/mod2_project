class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  before_action :already_logged_in?, only:[:new,:create]

  def new
  end

  def create
   user = User.find_by(username:params[:username])
   if user && user.authenticate(params[:password])
     session[:user_id] = user.id
     redirect_to user_path(user)
   else
     redirect_to login_path
   end
 end

 def destroy
   session[:user_id] = nil
   redirect_to login_path
 end

  private

  def find_user
    @user = User.find_by(id: params[:id])
  end
end
