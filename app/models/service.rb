class Service < ApplicationRecord
    has_and_belongs_to_many :doctors

    validates_presence_of :name
    validates_uniqueness_of :name
    
end
