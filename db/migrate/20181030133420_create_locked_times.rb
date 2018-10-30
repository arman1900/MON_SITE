class CreateLockedTimes < ActiveRecord::Migration[5.2]
  def change
    create_table :locked_times do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :user_id
      t.integer :doctor_id
      t.integer :service_id
      
      t.timestamps
    end
    add_index :locked_times, [:start_time, :user_id], unique: true
    add_index :locked_times, [:start_time, :doctor_id], unique: true
  end
end
