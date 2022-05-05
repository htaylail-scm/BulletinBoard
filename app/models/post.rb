class Post < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true

    def self.search(search)
        where("name LIKE ?", "%#{search}%") 
        where("content LIKE ?", "%#{search}%")
      end
end
