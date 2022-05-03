# email:string
# password_digest:string
#
# password:string virtual
# password_confirmation virtual
class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true, uniqueness: true, format:  { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/, message: "must be a valid email format" }
end