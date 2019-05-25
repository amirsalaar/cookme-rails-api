class User < ApplicationRecord
    has_secure_password

    has_one :payment_method, dependent: :destroy
    has_many :orders, dependent: :destroy
    has_many :foods, dependent: :destroy
    has_one_attached :avatar
    has_one_attached :certificate
    
    validates :first_name, :last_name, presence: true
    validates :email, presence: true, uniqueness: true, format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    
    before_validation :titleize_name

    private
    def titleize_name
        self.first_name = self.first_name&.titleize
        self.last_name = self.last_name&.titleize
    end
    
    def full_name
        self.first_name.strip.concat(' ', self.last_name.strip).titleize
    end
end
