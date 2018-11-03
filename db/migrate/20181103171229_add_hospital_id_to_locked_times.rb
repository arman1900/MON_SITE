class AddHospitalIdToLockedTimes < ActiveRecord::Migration[5.2]
  def change
    add_column :locked_times, :hospital_id, :integer
  end
end
