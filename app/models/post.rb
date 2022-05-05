class Post < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true  

    # def self.search_by(search_term)
    #   where("LOWER(name) LIKE :search_term"), search_term: "%#{search_term.downcase}%"
    # end
end