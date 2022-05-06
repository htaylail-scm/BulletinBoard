class Post < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true  

  # def self.search_by(search_term)
  #   where("LOWER(name) LIKE :search_term"), search_term: "%#{search_term.downcase}%"
  # end

  def self.to_csv(fields = column_names, options = {})
    CSV.generate(options) do |csv|
      csv << fields
      all.each do |post|
        csv << post.attributes.values_at(*fields)
      end
    end
  end

  def self.upload(file)
    CSV.foreach(file.path, headers: true) do |row|
      post_hash = row.to_hash
      post = find_or_create_by!(title: post_hash['title'], description: post_hash['description'])
      post.update(post_hash)
    end
  end
    
end