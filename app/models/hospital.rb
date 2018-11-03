class Hospital < ApplicationRecord
    has_many :doctors
    has_many :locked_times
    
    
    validates_presence_of :name, :location
    validates :name, length: {maximum: 100}
end
