class CreateHospitals < ActiveRecord::Migration[5.2]
  def change
    create_table :hospitals do |t|
      t.string :name, unique: true
      t.string :location, unique:true
      t.timestamps
    end
  end
end
