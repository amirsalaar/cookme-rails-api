class User < ApplicationRecord
    has_secure_password

    has_one :payment_method
    has_many :orders, dependent: :nullify
    has_many :foods, dependent: :destroy
    
    validates :first_name, :last_name, presence: true
    validates :email, presence: true, uniqueness: true, format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

    def full_name
        self.first_name.strip.concat(' ', self.last_name.strip).titleize
    end
end
