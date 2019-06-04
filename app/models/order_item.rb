class OrderItem < ApplicationRecord

  belongs_to :food
  belongs_to :order
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  before_validation :set_subtotal!

  private
  def set_subtotal!
    if self.food.sale_price != 0
      self.subtotal = self.quantity * self.food.sale_price
    else
      self.subtotal = self.quantity * self.food.price
    end
  end

end
