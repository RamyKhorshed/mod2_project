class AddCategoryToAchievements < ActiveRecord::Migration[5.1]
  def change
    add_column :achievements, :category, :string
  end
end
