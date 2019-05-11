class CreatePaymentMethods < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_methods do |t|
      t.hstore :billing_address
      t.integer :stripe_customer_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
