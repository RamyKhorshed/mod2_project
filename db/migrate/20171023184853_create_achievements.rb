class CreateAchievements < ActiveRecord::Migration[5.1]
  def change
    create_table :achievements do |t|
      t.string :name
      t.string :description
      t.string :img_reference

      t.timestamps
    end
  end
end
