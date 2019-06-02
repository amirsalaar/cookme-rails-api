class Tagging < ApplicationRecord
  belongs_to :food
  belongs_to :ingredient

  validates :ingredient_id, uniqueness: { scope: :food_id }

end
