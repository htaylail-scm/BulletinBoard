class User < ApplicationRecord

    # belongs_to :created_user, class_name: "User", foreign_key: "create_user_id"
    # belongs_to :updated_user, class_name: "User", foreign_key: "updated_user_id"

    has_secure_password

    # email validation
    validates :email, presence: true, uniqueness: true, format:  { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/, message: "must be a valid email format" }
    validates :name, presence: true
    #  validates :phone, format: { with: /^(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}/ , message: "must be a valid phone number"}
    
    # soft delete
    # acts_as_paranoid

   

end