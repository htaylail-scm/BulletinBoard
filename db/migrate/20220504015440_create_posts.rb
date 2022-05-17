class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      
      t.string :title, unique: true,  null: false, limit: 255
      t.text :description, null: false
      t.integer :status, null: false
      
      t.integer :created_user_id, null: false
      t.integer :updated_user_id, null: false
      t.integer :deleted_user_id

      
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.datetime :deleted_at
    end
  end
end
