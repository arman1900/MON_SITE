class AddRememberDigestToDoctors < ActiveRecord::Migration[5.2]
  def change
    add_column :doctors, :remember_digest, :string
  end
end
