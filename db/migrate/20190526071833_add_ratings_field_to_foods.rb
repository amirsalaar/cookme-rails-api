class AddRatingsFieldToFoods < ActiveRecord::Migration[5.2]
  def change
    add_column :foods, :ratings, :integer
  end
end
