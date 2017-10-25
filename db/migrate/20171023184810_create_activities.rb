class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.string :name
      t.string :category
      t.integer :points
      t.boolean :accomplished

      t.timestamps
    end
  end
end
