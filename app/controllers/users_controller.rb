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


     @ach = achievements_list

     @activities_list = Activity.distinct.pluck(:name)
     @public_achievements = find_user.achievements
     @all_activities = find_user.activities
     @grouped_activities = grouped_activities
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
    hash[grouped.keys[i]] = grouped[grouped.keys[i]].count #key/value of :name/count of like items
    i += 1
    end
    hash
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

    end
    if fitness_count >= 15 && !@user.achievements.find_by(name: "15 Fitness")

    end
    if fitness_count >= 20 && !@user.achievements.find_by(name: "20 Fitness")

    end
    if fitness_count >= 25 && !@user.achievements.find_by(name: "25 Fitness")
      
    end
  end

def achievements_list
  @achievements = []
end


#fitness methods, 5-25
  def fitness5
    if fitness_count == 5
      achievements_list << find_achievement("5 Fitness")
    end
  end
  def fitness10
    if fitness_count == 10
      achievements_list << find_achievement("10 Fitness")
    end
  end
#   def fitness15
#     if fitness_count == 15
#       achievements_list << find_achievement("15 Fitness")
#     end
#   end
#   def fitness20
#     if fitness_count == 20
#       achievements_list << find_achievement("20 Fitness")
#     end
#   end
#   def fitness25
#     if fitness_count == 25
#       achievements_list << find_achievement("25 Fitness")
#     end
#   end
#   #relationship methods, 5-25
#   def relationship5
#     if relationship_count == 5
#       achievements_list << find_achievement("5 Relationship")
#     end
#   end
#   def relationship10
#     if relationship_count == 10
#       achievements_list << find_achievement("10 Relationship")
#     end
#   end
#   def relationship15
#     if relationship_count == 15
#       achievements_list << find_achievement("15 Relationship")
#     end
#   end
#   def relationship20
#     if relationship_count == 20
#       achievements_list << find_achievement("20 Relationship")
#     end
#   end
#   def relationship25
#     if relationship_count == 25
#       achievements_list << find_achievement("25 Relationship")
#     end
#   end
# #intellectual methods, 5-25
#   def intellectual5
#     if intellectual_count == 5
#       achievements_list << find_achievement("5 Intellectual")
#     end
#   end
#   def intellectual10
#     if intellectual_count == 10
#       achievements_list << find_achievement("10 Intellectual")
#     end
#   end
#   def intellectual15
#     if intellectual_count == 15
#       achievements_list << find_achievement("15 Intellectual")
#     end
#   end
#   def intellectual20
#     if intellectual_count == 20
#       achievements_list << find_achievement("20 Intellectual")
#     end
#   end
#   def intellectual25
#     if intellectual_count == 25
#       achievements_list << find_achievement("25 Intellectual")
#     end
#   end
# #Purpose methods, 5-25
#   def purpose5
#     if purpose_count == 5
#       achievements_list << find_achievement("5 Purpose")
#     end
#   end
#   def purpose10
#     if purpose_count == 10
#       achievements_list << find_achievement("10 Purpose")
#     end
#   end
#   def purpose15
#     if purpose_count == 15
#       achievements_list << find_achievement("15 Purpose")
#     end
#   end
#   def purpose20
#     if purpose_count == 20
#       achievements_list << find_achievement("20 Purpose")
#     end
#   end
#   def purpose25
#     if purpose_count == 25
#       achievements_list << find_achievement("25 Purpose")
#     end
#   end
#   #professional methods, 5-25
#   def professional5
#     if professional_count == 5
#       achievements_list << find_achievement("5 Professional")
#     end
#   end
#   def professional10
#     if professional_count == 10
#       achievements_list << find_achievement("10 Professional")
#     end
#   end
#   def professional15
#     if professional_count == 15
#       achievements_list << find_achievement("15 Professional")
#     end
#   end
#   def professional20
#     if professional_count == 20
#       achievements_list << find_achievement("20 Professional")
#     end
#   end
#   def professional25
#     if professional_count == 25
#       achievements_list << find_achievement("25 Professional")
#     end
#   end

  def fitness_count
    find_user.activities.where(category: "Health & Fitness").where(accomplished: true).count
  end
  # def relationship_count
  #   find_user.activities.where(category: "Relationships & Well-Being").count
  # end
  # def intellectual_count
  #   find_user.activities.where(category: "Intellectual").count
  # end
  # def purpose_count
  #   find_user.activities.where(category: "Purpose").count
  # end
  # def professional_count
  #   find_user.activities.where(category: "Professional").count
  # end


  def find_achievement(name)
    Achievement.find_by(name: name)
  end


  def check_for_achievement_by_name(name)
    accomplished_activities.any? {|activity| activity.name == name}
  end


end
