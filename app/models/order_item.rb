class OrderItem < ApplicationRecord
  belongs_to :food
  belongs_to :order
  validates :order_id, uniqeness: { scope: :food_id }
end
