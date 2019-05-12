class Food < ApplicationRecord
    has_many :order_items, dependent: :nullify
    has_many :schedule, dependent: :destroy
    belongs_to :cook,  class_name: "User", foreign_key: "user_id"

    validate :is_cook

    private
    def is_cook
        errors.add(:food, "User must be a verified cook.") unless cook && cook.verified?
    end
    
end
