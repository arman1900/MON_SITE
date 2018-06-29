class CreateDevelopers < ActiveRecord::Migration[5.2]
  def change
    create_table :developers do |t|
      t.string :token

      t.timestamps
    end
    add_index :developers, :token, unique: true
  end
end
