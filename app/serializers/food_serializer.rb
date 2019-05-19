class FoodSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :name,
    :description,
    :price,
  )
  belongs_to :cook
  has_many :schedules

  class ScheduleSerializer < ActiveModel::Serializer
    attributes :id, :weekday, :quantity
  end
  
  class UserSerializer < ActiveModel::Serializer
    attributes(
      :id,
      :first_name,
      :last_name,
      :full_name,
      :email,
      :role
    )
  end
end
