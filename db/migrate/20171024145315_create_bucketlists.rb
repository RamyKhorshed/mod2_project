class CreateBucketlists < ActiveRecord::Migration[5.1]
  def change
    create_table :bucketlists do |t|
      t.string :name
      t.string :description
      t.integer :user_id

      t.timestamps
    end
  end
end
