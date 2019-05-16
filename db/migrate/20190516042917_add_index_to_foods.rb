class AddIndexToFoods < ActiveRecord::Migration[5.2]
  def change
    add_index :foods, [:name, :user_id], :unique =>  true
  end
end
