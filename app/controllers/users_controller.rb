class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  before_action :already_logged_in?, only:[:new,:create]

  def index
    @users = User.all
  end

  def new
  end

  def create
    @user = User.new(user_params)
      if @user.save && params[:password] == params[:password_confirmation] #should be user_params both times??
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        redirect_to controller: 'users', action: 'new'
      end
   end


   def show
     find_user
     @grouped_user_fitness = grouped_user_fitness
     @grouped_user_relationship = grouped_user_relationship
     @grouped_user_intellectual = grouped_user_intellectual
     @grouped_user_purpose = grouped_user_purpose
     @grouped_user_professional = grouped_user_professional

     @activities_list = Activity.distinct.pluck(:name)
     @public_achievements = find_user.achievements
     @unaccomplished_activities = find_user.activities.where(accomplished: false)
     @grouped_accomplished_activities = grouped_activities
     @activities = Activity.new
     @categories = ['Health & Fitness', 'Relationships & Well-Being', 'Intellectual', 'Purpose', 'Professional']
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
    session[:user_id] = nil
    redirect_to '/login'
  end


  private
  def user_params
   params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
  end
  def find_user
    @user = User.find_by(id: params[:id])
  end

  def grouped_activities
    grouped = find_user.activities.where(accomplished: true).group_by(&:name) #finds all activities for user(find_user.activities), selects only the acomplished ones (.where(accomplished: true)), and groups those with identical activities by :name
    i = 0 #counter for while loop
    hash = {} #empty hash to add to
    while i < grouped.length do
    hash[Activity.find_by(name: grouped.keys[i])] = grouped[grouped.keys[i]].count #key/value of :name/count of like items
    i += 1
    end
    hash
  end

  def grouped_user_fitness
    grouped_activities.select {|activity| activity.category == "Health & Fitness"}
  end
  def grouped_user_relationship
    grouped_activities.select {|activity| activity.category == "Relationships & Well-Being"}
  end
  def grouped_user_intellectual
    grouped_activities.select {|activity| activity.category == "Intellectual"}
  end
  def grouped_user_purpose
    grouped_activities.select {|activity| activity.category == "Purpose"}
  end
  def grouped_user_professional
    grouped_activities.select {|activity| activity.category == "Professional"}
  end
  
  def category_points
    grouped = find_user.activities.where(accomplished: true).group_by(&:category) #finds all activities for user(find_user.activities), selects only the acomplished ones (.where(accomplished: true)), and groups those with identical activities by :name
    scores = {}
    @categories.each do |category|
      category_sum = 0
      if !!grouped[category]
        grouped[category].each do |activity|
          category_sum += activity.points
        end
      end
      scores[category] = category_sum
    end
    @scores_array = scores.to_a
  end

end
