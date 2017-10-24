class AchievementsController < ApplicationController
  def index
    @achievements = Achievement.all
  end

  def show
    @achievement = Achievement.find_by(id: params[:id])
    @users = users_with_achievement
  end


  def users_with_achievement
    @achievement = Achievement.find_by(id: params[:id])
    achieved = []
    User.all.collect do |user|
      user.achievements.collect do |achievement|
        if achievement.name == @achievement.name
          achieved << user
        end
      end
    end
    achieved
  end

  private

  def achievement_params
    params.require(:achievement).permit(:name, :description, :img_reference)
  end

end
