class AddDoctorsToServices < ActiveRecord::Migration[5.2]
  def change
    create_table :doctors_services, id: false do |t|
      t.belongs_to :doctor, index:true, unique:true
      t.belongs_to :service, index:true, unique:true
    end
  end
end
