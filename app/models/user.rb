class User < ApplicationRecord

    belongs_to :created_user, class_name: "User", foreign_key: "created_user_id"
    belongs_to :updated_user, class_name: "User", foreign_key: "updated_user_id"

    # virtual attributes for authentication
    has_secure_password

    validates :email, presence: true, uniqueness: true, format:  { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/, message: "must be a valid email format" }
    validates :name, :photo, presence: true   
    validates :phone, :presence => {:message => 'Only number accept'},
                     :numericality => true,
                     :length => { :minimum => 10, :maximum => 15 }


    PASSWORD_FORMAT = /\A
    (?=.{8,})          # Must contain 8 or more characters
    (?=.*\d)           # Must contain a digit
    (?=.*[a-z])        # Must contain a lower case character
    (?=.*[A-Z])        # Must contain an upper case character
    (?=.*[[:^alnum:]]) # Must contain a symbol
    /x
    validates :password, confirmation: true, presence: true, format: { with: PASSWORD_FORMAT }, on: :create 
  
    # to check old password with new password
    attr_accessor :old_password

    # image
    has_one_attached :photo

    # soft delete
    acts_as_paranoid

end

