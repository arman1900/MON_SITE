class Icon < ApplicationRecord
    validates_presence_of :url
    belongs_to :category
end
