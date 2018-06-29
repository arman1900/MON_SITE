class Category < ApplicationRecord
    has_many :posts
    has_one :icon
    #belongs to :user
    validates_presence_of :name
end
