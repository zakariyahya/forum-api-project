# app/models/user.rb
class User < ApplicationRecord
    has_many :user_forums
    has_many :forums, through: :user_forums
    has_secure_password
  
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
  
  end
  