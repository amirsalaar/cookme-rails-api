class OrderSerializer < ActiveModel::Serializer
  attributes :id, :total
  # has_many :order_items
  has_many :foods, through: :order_items

  class FoodSerializer < ActiveModel::Serializer
    attributes :id, :name, :price
  end
end
