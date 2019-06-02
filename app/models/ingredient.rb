class Ingredient < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :foods, through: :taggings

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  before_validation :downcase_name

  private
  def downcase_name
      self.name&.downcase!
  end
end
