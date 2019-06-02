class Food < ApplicationRecord
    belongs_to :cook,  class_name: "User", foreign_key: "user_id"
    has_many :order_items, dependent: :nullify
    has_many :orders, through: :order_items
    has_many :schedules, dependent: :destroy
    has_many_attached :pictures
    has_many :taggings, dependent: :destroy
    has_many :ingredients, through: :taggings

    validates :name, presence: true, uniqueness: { scope: [:user_id], case_sensitive: false, message: "must be unique for a cook" }, on: :create
    validates :description, presence: true
    validate :set_default_price
    validate :is_cook
    before_validation :titleize_name
    before_validation :sentence_case

    scope(:search, ->(query) { where("title ILIKE ? OR description ILIKE ?", "%#{query}%", "%#{query}%") })

    
    private
    def is_cook
        errors.add(:user, "User must be a verified cook.") unless cook&.verified?
    end
    
    def set_default_price
        self.price ||= 0
    end
    
    def titleize_name
        self.name = self.name&.titleize
    end

    def sentence_case
        self.description = (self.description.split('.').map {|sentence| sentence.strip.capitalize }).join('. ')
        self.description.concat('.')
    end
end
