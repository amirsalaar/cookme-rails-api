class ScheduleSerializer < ActiveModel::Serializer
  attributes(
    :weekday,
    :quantity
  )
  belongs_to :food
end
