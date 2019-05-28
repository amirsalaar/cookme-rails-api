class OrderItem < ApplicationRecord
  
  include Messenger

  belongs_to :food
  belongs_to :order
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  

end
