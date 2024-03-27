class Forum < ApplicationRecord
    has_many :user_forums
    has_many :users, through: :user_forums
end
