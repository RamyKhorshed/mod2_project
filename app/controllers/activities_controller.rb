class ActivitiesController < ApplicationController

  def index
    @fitness = activity_fitness
    @relationship = activity_relationship
    @intellectual = activity_intellectual
    @domestic = activity_domestic
    @soul_searching = activity_soul_searching
  end

  def new

  end

  def show
    @users = users_with_activity
    @activity = Activity.find_by(id: params[:id])
  end

  def create
    @user = User.find_by(id: params[:user_id]) #to associate the new activity with the user making it
    previous_activity = Activity.find_by(name: params[:activity]) #finds previoius activity with same name
    @activity = previous_activity.dup #makes a copy of the previous activity
    @activity.accomplished = false #sets accomplished to false on the new activity
    @activity.save #saves the activity
    @user.activities << @activity #associated the activity to the current user
    redirect_to user_path(@user) #redirect to
  end

  def delete
   @activity = Activity.find_by(id: params[:activity_id])
   @activity.destroy
   redirect_to user_path(session[:user_id])
 end

 def update
   @activity = Activity.find_by(id: params[:activity_id])
   @user = @activity.user_ids
   @activity.accomplished = true
   @activity.save
   redirect_to user_path(@user)
 end

  # def create
  #   @activity = Activity.new
  #   @user = User.find_by(id: params[:user_id])
  #   byebug
  #   hash = params[:activity][:name]
  #   hash.each do |activity_id|
  #     act = Activity.find_or_create_by(id: activity_id)
  #     @user.activities << act
  #   end
  # end

  def users_with_activity
    @activity = Activity.find_by(id: params[:id])
    activities = []
    User.all.collect do |user|
      user.activities.collect do |activity|
        if activity.name == @activity.name
          activities << user
        end
      end
    end
    activities
  end

  def activity_fitness #hiking, biking, gym, etc
    Activity.all.where(category: 'Health & Fitness')
  end

  def activity_relationship #improv classes, lunch date, widening your interpersonal skills
    Activity.all.where(category: 'Relationships & Well-Being')
  end

  def activity_intellectual #night classes, books read, new topic discovered, talk went to
    Activity.all.where(category: 'Intellectual')
  end

  def activity_domestic #stuff around the house. vaccuming, repairs, housework, mowing the lawn, hanging pictures
    Activity.all.where(category: 'Purpose')
  end

  def activity_soul_searching #meditation, yoga, spiritual explorations
    Activity.all.where(category: 'Professional')
  end


end
