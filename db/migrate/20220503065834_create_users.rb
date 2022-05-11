class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false

      t.string :photo, limit: 255
      # t.string :role, null: false, limit: 1
      t.string :role, default: "1"
      t.string :phone, limit: 20
      t.string :address, limit: 255
      t.date :dob
      t.bigint :create_user_id, null: false
      t.bigint :updated_user_id, null: false
      t.integer :deleted_user_id
      
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.datetime :deleted_at

    end
  end
end
