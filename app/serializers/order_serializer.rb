class OrderSerializer < ActiveModel::Serializer
  attributes :id, :total
  has_many :foods

  class FoodSerializer < ActiveModel::Serializer
    attributes :id, :name
  end
end
