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
     find_user #finds the current user for use in view
     all_achievements
     @grouped_user_activities = grouped_user_activities
     @grouped_user_achievements = grouped_user_achievements
     @any_achievements = any_achievements?
     @any_activities = any_activities?

     @activities_list = Activity.distinct.pluck(:name)
     @public_achievements = find_user.achievements
     @unaccomplished_activities = find_user.activities.where(accomplished: false)
     @grouped_accomplished_activities = grouped_activities
     @activities = Activity.new
     @categories = ['Health & Fitness', 'Relationships & Well-Being', 'Intellectual', 'Purpose', 'Professional']
     category_points
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

  def accomplished_activities
    @accomplished_activities = find_user.activities.where(accomplished: true)
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

#get all activities for each category
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

  def grouped_user_activities
    {"Fitness" => grouped_user_fitness, "Relationship" => grouped_user_relationship, "Intellectual" => grouped_user_intellectual, "Purpose" => grouped_user_purpose, "Professional" => grouped_user_professional}
  end

  #get all achievments by category. called in @grouped_achievements in show method.
  def grouped_fitness_achievements
    find_user.achievements.where(category: "Health & Fitness")
  end
  def grouped_relationship_achievements
    find_user.achievements.where(category: "Relationships & Well-Being")
  end
  def grouped_intellectual_achievements
    find_user.achievements.where(category: "Intellectual")
  end
  def grouped_purpose_achievements
    find_user.achievements.where(category: "Purpose")
  end
  def grouped_professional_achievements
    find_user.achievements.where(category: "Professional")
  end

  def grouped_user_achievements
    {"Fitness" => grouped_fitness_achievements, "Relationship" => grouped_relationship_achievements, "Intellectual" => grouped_intellectual_achievements, "Purpose" => grouped_purpose_achievements, "Professional" => grouped_professional_achievements}
  end


  def any_achievements?
    if find_user.achievements.empty?
      false
    else
      true
    end
  end
  def any_activities?
    if find_user.activities.where(accomplished: true).empty?
      false
    else
      true
    end
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

  def all_achievements #calls all grouping achievements methods. fitness_achievements, relationship_achievements...
    fitness_achievements
    relationship_achievements
    intellectual_achievements
    purpose_achievements
    professional_achievements
    miscellaneous_achievements
  end

  def fitness_achievements #adds all fitness achievements
    i = 5
    while i < 30 do
      if fitness_count >= i && !@user.achievements.find_by(name: "#{i} Fitness")
        @user.achievements << Achievement.find_by(name: "#{i} Fitness")
      end
      i += 5
    end
  end
  def relationship_achievements #adds all relationship achievements
    i = 5
    while i < 30 do
      if relationship_count >= i && !@user.achievements.find_by(name: "#{i} Relationship")
        @user.achievements << Achievement.find_by(name: "#{i} Relationship")
      end
      i += 5
    end
  end
  def intellectual_achievements #adds all intellectual achievements
    i = 5
    while i < 30 do
      if intellectual_count >= i && !@user.achievements.find_by(name: "#{i} Intellectual")
        @user.achievements << Achievement.find_by(name: "#{i} Intellectual")
      end
      i += 5
    end
  end
  def purpose_achievements #adds all purpose achievements
    i = 5
    while i < 30 do
      if purpose_count >= i && !@user.achievements.find_by(name: "#{i} Purpose")
        @user.achievements << Achievement.find_by(name: "#{i} Purpose")
      end
      i += 5
    end
  end
  def professional_achievements #adds all professional achievements
    i = 5
    while i < 30 do
      if professional_count >= i && !@user.achievements.find_by(name: "#{i} Professional")
        @user.achievements << Achievement.find_by(name: "#{i} Professional")
      end
      i += 5
    end
  end
  def miscellaneous_achievements #all miscellaneous achievements. Basically little easter eggs
    if check_for_achievement_by_name("Run a Marathon") && check_for_achievement_by_name("Read a book a week")
      @achievement_brain_and_brawn = true
    else
      @achievement_brain_and_brawn = false
    end
    if check_for_achievement_by_name("Speak 3 Languages") && check_for_achievement_by_name("Network")
      @achievement_globalized = true
    else
      @achievement_globalized = false
    end
  end

 #gets counts of activities by category
  def fitness_count
    find_user.activities.where(category: "Health & Fitness").where(accomplished: true).count
  end
  def relationship_count
    find_user.activities.where(category: "Relationships & Well-Being").where(accomplished: true).count
  end
  def intellectual_count
    find_user.activities.where(category: "Intellectual").where(accomplished: true).count
  end
  def purpose_count
    find_user.activities.where(category: "Purpose").where(accomplished: true).count
  end
  def professional_count
    find_user.activities.where(category: "Professional").where(accomplished: true).count
  end

 #abstracts out achievement finding
  def find_achievement(name)
    Achievement.find_by(name: name)
  end


  def check_for_achievement_by_name(name)
    accomplished_activities.any? {|activity| activity.name == name}
  end


end
