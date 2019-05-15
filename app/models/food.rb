class Food < ApplicationRecord
    has_many :order_items, dependent: :nullify
    belongs_to :cook,  class_name: "User", foreign_key: "user_id"
    has_many :schedules, dependent: :destroy
    # accepts_nested_attributes_for :schedules, allow_destroy: true, reject_if: proc { |schedule| schedule['weekday'].blank? }

    validates :schedule, presence: true
    validate :set_default_price

    private
    def is_cook
        errors.add(:food, "User must be a verified cook.") unless cook&.verified?
    end

    def set_default_price
        self.price ||= 0
    end
    
end
