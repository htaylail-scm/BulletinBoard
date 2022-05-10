class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.integer :status, default: "1"
      
      t.timestamps

      # t.integer :status, null: false

      # t.integer :create_user_id, null: false
      # t.integer :updated_user_id, null: false
      # t.integer :deleted_user_id
      
      # t.datetime :created_at, null: false
      # t.datetime :updated_at, null: false
      # t.datetime :deleted_at
    end
  end
end
