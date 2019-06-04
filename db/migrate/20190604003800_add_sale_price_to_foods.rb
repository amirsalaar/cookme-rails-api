class AddSalePriceToFoods < ActiveRecord::Migration[5.2]
  def change
    add_column :foods, :sale_price, :decimal, precision: 5, scale: 2, default: 0
  end
end
