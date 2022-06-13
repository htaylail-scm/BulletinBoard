# README

ruby version => ruby '2.6.10'
rails version => 'rails', '~> 6.1.5', '>= 6.1.5.1'

* gem install
run: bundle install

* project setup

* delete or make comment these two lines in user.rb (temporarily)
belongs_to :created_user, class_name: 'User', foreign_key: 'created_user_id'
belongs_to :updated_user, class_name: 'User', foreign_key: 'updated_user_id'

* add these two lines back in user.rb
belongs_to :created_user, class_name: 'User', foreign_key: 'created_user_id'
belongs_to :updated_user, class_name: 'User', foreign_key: 'updated_user_id'

* run project
 rails s
