class AddIndexToSchedules < ActiveRecord::Migration[5.2]
  def change
    add_index :schedules, [:food_id, :quantity, :weekday],:unique => true 
  end
end
