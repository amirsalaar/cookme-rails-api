class OrderItem < ApplicationRecord
  
  # include Messenger

  belongs_to :food
  belongs_to :order
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  before_validation :set_subtotal!

  # after_create :send_message

  private
  # def send_message
  #   message = "Your order #{self.order.id} was placed!"
  #   number = ENV['TEST_PHONE_NUMBER']
  #   self.send_sms(number, message)
  # end

  def set_subtotal!
    self.subtotal = self.quantity * self.food.price
  end

end
