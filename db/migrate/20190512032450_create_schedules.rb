class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.time :date
      t.integer :weekday
      t.integer :quantity
      t.references :food, foreign_key: true

      t.timestamps
    end
  end
end
