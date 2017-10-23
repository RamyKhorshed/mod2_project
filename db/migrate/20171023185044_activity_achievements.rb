class ActivityAchievements < ActiveRecord::Migration[5.1]
  def change
    create_table :activity_achievements  do |t|
      t.integer :activity_id
      t.integer :achievement_id

      t.timestamps
    end
  end
end
