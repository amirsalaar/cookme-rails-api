class ChangeTotalTypeInOrders < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :total, :decimal, precision: 5, scale: 2
  end
end
