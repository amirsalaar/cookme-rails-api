class Food < ApplicationRecord
    has_many :order_items, dependent: :nullify
    belongs_to :cook,  class_name: "User", foreign_key: "user_id"
    has_many :schedules, dependent: :destroy

    validates :name, uniqueness: { scope: [:user_id], message: "must be unique for a cook" }, on: :create
    validate :set_default_price
    validate :is_cook

    private
    def is_cook
        errors.add(:user, "User must be a verified cook.") unless cook&.verified?
    end

    def set_default_price
        self.price ||= 0
    end
    
end
