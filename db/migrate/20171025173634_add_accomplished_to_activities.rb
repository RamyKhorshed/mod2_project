class AddAccomplishedToActivities < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :accomplished, :boolean
  end
end
