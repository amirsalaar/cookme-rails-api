class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :nullify
  has_many :foods, through: :order_items
  
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
  before_validation :set_total!
  
  private
  def set_total!
    self.total = foods.map(&:price).sum
  end

end
