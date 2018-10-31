class Hospital < ApplicationRecord
    has_many :doctors
        validates_presence_of :name, :location
        validates :name, length: {maximum: 100}
end
