class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.string :name
      t.text :description
      t.decimal :price, :precision => 5, scale: 2

      t.timestamps
    end
  end
end
