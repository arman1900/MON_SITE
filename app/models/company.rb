class Company < ApplicationRecord
    has_and_belongs_to_many :users
    has_many :categories
    has_many :posts, through: :categories
    validates_presence_of :name
end
