class Schedule < ApplicationRecord
  belongs_to :food

  validates :weekday, presence: true, inclusion: { in: (0..6), message: "weekday should be an integer within 0 to 6" }
  validates :quantity, numericality: { greater_than_or_equal_to: 0}
  validates_presence_of :food, on: :create

end
