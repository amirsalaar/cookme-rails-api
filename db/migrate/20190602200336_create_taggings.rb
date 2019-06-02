class CreateTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :taggings do |t|
      t.references :food, foreign_key: true
      t.references :ingredient, foreign_key: true

      t.timestamps
    end
  end
end
