class LockedTime < ApplicationRecord
    belongs_to :doctor
    belongs_to :user
    belongs_to :hospital
    belongs_to :service
    
    validates_presence_of :start_time, :end_time, :user_id, :service_id, :hospital_id, :doctor_id
    
end
