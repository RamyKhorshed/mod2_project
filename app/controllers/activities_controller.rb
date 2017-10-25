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
    @activity = Activity.new
    @user = User.find_by(id: params[:user_id])
    hash = params[:activity][:name]
    byebug
    hash.each do |activity_id|
      act = Activity.find_or_create_by(id: activity_id)
      @user.activities << act
    end
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
