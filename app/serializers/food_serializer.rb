class FoodSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :name,
    :description,
    :price,
  )
  belongs_to :cook
  has_many :schedules
end
