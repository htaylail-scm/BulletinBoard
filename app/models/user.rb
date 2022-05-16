class User < ApplicationRecord
    

    # belongs_to :created_user, class_name: "User", foreign_key: "created_user_id"
    # belongs_to :updated_user, class_name: "User", foreign_key: "updated_user_id"

    # virtual attributes for authentication
    has_secure_password

    # email validation to test again
    # validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
    validates :email, presence: true, uniqueness: true, format:  { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/, message: "must be a valid email format" }
    validates :name, :photo, presence: true
    validates :password, confirmation: true, presence: true,on: :create
   
    # to check old password with new password
     attr_accessor :old_password

    # image
    has_one_attached :photo

    # soft delete
    # acts_as_paranoid   
    

end