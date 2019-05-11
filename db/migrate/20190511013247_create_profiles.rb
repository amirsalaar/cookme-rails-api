class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, index: {:unique =>  true}
      t.string :password_digest
      t.hstore :address
      t.string :phone_number

      t.timestamps
    end
  end
end
