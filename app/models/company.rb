class Company < ApplicationRecord
    has_and_belongs_to_many :users
    has_many :categories
    validates_presence_of :name
end
