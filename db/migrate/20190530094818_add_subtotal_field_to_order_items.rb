class AddSubtotalFieldToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :subtotal, :decimal, :precision => 5, scale: 2
  end
end
