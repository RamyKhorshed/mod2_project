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

     @grouped_fitness_achievements = grouped_fitness_achievements
     @grouped_relationship_achievements = grouped_relationship_achievements
     @grouped_intellectual_achievements = grouped_intellectual_achievements
     @grouped_purpose_achievements = grouped_purpose_achievements
     @grouped_professional_achievements = grouped_professional_achievements

     @activities_list = Activity.distinct.pluck(:name)
     @public_achievements = find_user.achievements
     @unaccomplished_activities = find_user.activities.where(accomplished: false)
     @grouped_accomplished_activities = grouped_activities
     @activities = Activity.new
     @categories = ['Health & Fitness', 'Relationships & Well-Being', 'Intellectual', 'Purpose', 'Professional']
     achievements
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

  def grouped_fitness_achievements
    # binding.pry
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

  def achievements
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
    if fitness_count >= 5 && !@user.achievements.find_by(name: "5 Fitness")
      @user.achievements << Achievement.find_by(name: "5 Fitness")
    end
    if fitness_count >= 10 && !@user.achievements.find_by(name: "10 Fitness")
      @user.achievements << Achievement.find_by(name: "10 Fitness")
    end
    if fitness_count >= 15 && !@user.achievements.find_by(name: "15 Fitness")
      @user.achievements << Achievement.find_by(name: "15 Fitness")
    end
    if fitness_count >= 20 && !@user.achievements.find_by(name: "20 Fitness")
      @user.achievements << Achievement.find_by(name: "20 Fitness")
    end
    if fitness_count >= 25 && !@user.achievements.find_by(name: "25 Fitness")
      @user.achievements << Achievement.find_by(name: "25 Fitness")
    end

    if relationship_count >= 5 && !@user.achievements.find_by(name: "5 Relationship")
      @user.achievements << Achievement.find_by(name: "5 Relationship")
    end
    if relationship_count >= 10 && !@user.achievements.find_by(name: "10 Relationship")
      @user.achievements << Achievement.find_by(name: "10 Relationship")
    end
    if relationship_count >= 15 && !@user.achievements.find_by(name: "15 Relationship")
      @user.achievements << Achievement.find_by(name: "15 Relationship")
    end
    if relationship_count >= 20 && !@user.achievements.find_by(name: "20 Relationship")
      @user.achievements << Achievement.find_by(name: "20 Relationship")
    end
    if relationship_count >= 25 && !@user.achievements.find_by(name: "25 Relationship")
      @user.achievements << Achievement.find_by(name: "25 Relationship")
    end

    if intellectual_count >= 5 && !@user.achievements.find_by(name: "5 Intellectual")
      @user.achievements << Achievement.find_by(name: "5 Intellectual")
    end
    if intellectual_count >= 10 && !@user.achievements.find_by(name: "10 Intellectual")
      @user.achievements << Achievement.find_by(name: "10 Intellectual")
    end
    if intellectual_count >= 15 && !@user.achievements.find_by(name: "15 Intellectual")
      @user.achievements << Achievement.find_by(name: "15 Intellectual")
    end
    if intellectual_count >= 20 && !@user.achievements.find_by(name: "20 Intellectual")
      @user.achievements << Achievement.find_by(name: "20 Intellectual")
    end
    if intellectual_count >= 25 && !@user.achievements.find_by(name: "25 Intellectual")
      @user.achievements << Achievement.find_by(name: "25 Intellectual")
    end

    if purpose_count >= 5 && !@user.achievements.find_by(name: "5 Purpose")
      @user.achievements << Achievement.find_by(name: "5 Purpose")
    end
    if purpose_count >= 10 && !@user.achievements.find_by(name: "10 Purpose")
      @user.achievements << Achievement.find_by(name: "10 Purpose")
    end
    if purpose_count >= 15 && !@user.achievements.find_by(name: "15 Purpose")
      @user.achievements << Achievement.find_by(name: "15 Purpose")
    end
    if purpose_count >= 20 && !@user.achievements.find_by(name: "20 Purpose")
      @user.achievements << Achievement.find_by(name: "20 Purpose")
    end
    if purpose_count >= 25 && !@user.achievements.find_by(name: "25 Purpose")
      @user.achievements << Achievement.find_by(name: "25 Purpose")
    end

    if professional_count >= 5 && !@user.achievements.find_by(name: "5 Professional")
      @user.achievements << Achievement.find_by(name: "5 Professional")
    end
    if professional_count >= 10 && !@user.achievements.find_by(name: "10 Professional")
      @user.achievements << Achievement.find_by(name: "10 Professional")
    end
    if professional_count >= 15 && !@user.achievements.find_by(name: "15 Professional")
      @user.achievements << Achievement.find_by(name: "15 Professional")
    end
    if professional_count >= 20 && !@user.achievements.find_by(name: "20 Professional")
      @user.achievements << Achievement.find_by(name: "20 Professional")
    end
    if professional_count >= 25 && !@user.achievements.find_by(name: "25 Professional")
      @user.achievements << Achievement.find_by(name: "25 Professional")
    end
  end


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


  def find_achievement(name)
    Achievement.find_by(name: name)
  end


  def check_for_achievement_by_name(name)
    accomplished_activities.any? {|activity| activity.name == name}
  end


end
