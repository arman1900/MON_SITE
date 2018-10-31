class LockedTime < ApplicationRecord
    belongs_to :doctors
    belongs_to :users
end
