class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    enable_extension "hstore"
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, index: { :unique => true }
      t.string :password_digest
      t.hstore :address
      t.string :phone_number
      t.boolean :verified, :default => false
      t.integer :role

      t.timestamps
    end
  end
end
