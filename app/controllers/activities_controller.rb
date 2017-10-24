class ActivitiesController < ApplicationController
  def new

  end

  def create
    @activity = Activity.new
    @user = User.find_by(id: params[:user_id])
    hash = params[:activity][:name]
    byebug
    hash.each do |activity_id|
      act = Activity.find_or_create_by(id: activity_id)
      @user.activities << act
    end
  end
end
