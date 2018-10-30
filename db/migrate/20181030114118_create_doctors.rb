class CreateDoctors < ActiveRecord::Migration[5.2]
  def change
    create_table :doctors do |t|
      t.string :username, unique: true
      t.string :email, unique: true
      t.string :password_digest
      t.time :start_time
      t.time :end_time
      t.integer :hospital_id
      t.timestamps
    end
  end
end
