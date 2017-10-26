class ActivitiesController < ApplicationController

  def index
    @fitness = activity_fitness
    @relationship = activity_relationship
    @intellectual = activity_intellectual
    @purpose = activity_purpose
    @professional = activity_professional
  end

  def new

  end

  def show
    @users = users_with_activity
    @activity = Activity.find_by(id: params[:id])
  end

  def create
    if activity_params[:category]
      create_new_activity
    else
      create_from_select
    end
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

  private

  def activity_params
   params.require(:activity).permit(:name, :category, :points, :accomplished)
  end

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
    activities.uniq {|p| p.name}
  end

  def create_new_activity
    @user = User.find_by(id: params[:activity][:user_id]) #how do I put this in string params, and make it optional for the creation of an activity?
    @activity = Activity.create(activity_params)
    @user.activities << @activity
    redirect_to user_path(@user)
  end

  def create_from_select #same question as in create_new_activity
    @user = User.find_by(id: params[:activity][:user_id]) #to associate the new activity with the user making it
    previous_activity = Activity.find_by(name: activity_params[:name]) #finds previoius activity with same name
    @activity = previous_activity.dup #makes a copy of the previous activity
    @activity.accomplished = false #sets accomplished to false on the new activity
    @activity.save #saves the activity
    @user.activities << @activity #associated the activity to the current user
    redirect_to user_path(@user) #redirect to
  end

  def activity_fitness #hiking, biking, gym, etc
    Activity.all.where(category: 'Health & Fitness').uniq {|p| p.name} #removes duplicate activities
  end

  def activity_relationship #improv classes, lunch date, widening your interpersonal skills
    Activity.all.where(category: 'Relationships & Well-Being').uniq {|p| p.name}
  end

  def activity_intellectual #night classes, books read, new topic discovered, talk went to
    Activity.all.where(category: 'Intellectual').uniq {|p| p.name}
  end

  def activity_purpose #stuff around the house. vaccuming, repairs, housework, mowing the lawn, hanging pictures
    Activity.all.where(category: 'Purpose').uniq {|p| p.name}
  end

  def activity_professional #Work life, tasks, projects
    Activity.all.where(category: 'Professional').uniq {|p| p.name}
  end


end
