class AddIinToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :Iin, :string
  end
end
