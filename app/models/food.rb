class Food < ApplicationRecord
    belongs_to :cook,  class_name: "User", foreign_key: "user_id"
    has_many :order_items, dependent: :nullify
    has_many :orders, through: :order_items
    has_many :schedules, dependent: :destroy
    has_many_attached :pictures

    validates :name, uniqueness: { scope: [:user_id], case_sensitive: false, message: "must be unique for a cook" }, on: :create
    validates :description, presence: true
    validate :set_default_price
    validate :is_cook

    scope(:search, ->(query) { where("title ILIKE ? OR description ILIKE ?", "%#{query}%", "%#{query}%") })

    private
    def is_cook
        errors.add(:user, "User must be a verified cook.") unless cook&.verified?
    end

    def set_default_price
        self.price ||= 0
    end
    
end
