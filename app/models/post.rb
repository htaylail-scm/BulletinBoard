class Post < ApplicationRecord

  belongs_to :created_user, class_name: "User", foreign_key: "created_user_id"
  belongs_to :updated_user, class_name: "User", foreign_key: "updated_user_id"
  
  validates :title, presence: true
  validates :description, presence: true 


  require 'csv'

  def self.to_csv(fields = column_names, options = {})
    CSV.generate(options) do |csv|
      csv << fields
      all.each do |post|
        csv << post.attributes.values_at(*fields)
      end
    end
  end

  def self.upload(file,created_user_id,updated_user_id)
    CSV.foreach(file.path, headers: true) do |row|
      post = find_by(id: row["id"]) || new # if the same id found , create new one
      post.attributes = row.to_hash.slice(*updatable_attributes) # obtain data from csv file
      post.save!(validate: false) # save without passing through validation
    end
  end  
  
  # set colunm name
  def self.updatable_attributes
    ['title', 'description','status','created_user_id','updated_user_id']
  end
  
end