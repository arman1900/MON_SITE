class Service < ApplicationRecord
    has_and_belongs_to_many :doctors
    has_many :locked_times
    has_many :hospitals, ->{ distinct }, through: :doctors

    validates_presence_of :name
    validates_uniqueness_of :name
    
end
