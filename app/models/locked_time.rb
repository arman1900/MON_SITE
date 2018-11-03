class LockedTime < ApplicationRecord
    belongs_to :doctor
    belongs_to :user
    belongs_to :hospital
    belongs_to :service
    before_create :accept_false
    
    validates_presence_of :start_time, :end_time, :user_id, :service_id, :hospital_id, :doctor_id
    
    def accept_false 
        self.accepted = false
    end
end
