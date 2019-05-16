class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :nullify
  has_many :foods, through: :order_items
end
