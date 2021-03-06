class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

   helper_method :current_user, :logged_in?
   before_action :authorized



   private

   def authorized
     redirect_to login_path unless logged_in?
   end

   def current_user
     @current_user ||= User.find_by(id: session[:user_id])
   end

   def logged_in?
     !!current_user
   end

   def already_logged_in?
     redirect_to user_path(current_user) if logged_in?
   end
end
