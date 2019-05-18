class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :nullify
  has_many :foods, through: :order_items
  
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
  before_validation :set_total!

  # def place(order_details)
  #   order_details.map do |order_detail|
  #     self.order_items.create(order_id: self.id, food_id: order_detail[:food_id], quantity: order_detail[:order_quantity]).save!
  #   end
  # end

  def place(order_details)
    (order_details.filter {|od| od.is_a? Hash }).each do |valid_od|
      self.order_items.create(order_id: self.id, food_id: valid_od["food_id"], quantity: valid_od["order_quantity"]).save!
    end
  end
  
  def set_total!
    self.total = foods.map(&:price).sum
  end
end
