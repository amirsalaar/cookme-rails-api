class User < ApplicationRecord
    has_secure_password

    has_one :payment_method, dependent: :destroy
    has_many :orders, dependent: :destroy
    has_many :foods, dependent: :destroy
    has_one_attached :avatar
    has_one_attached :certificate
    
    validates :first_name, :last_name, presence: true
    validates :email, presence: true, uniqueness: { case_sensitive: false }, format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    
    before_validation :titleize_name
    before_validation :downcase_email!

    geocoded_by :join_address
    after_validation :geocode

    
    def full_name
        first_name.strip.concat(' ', last_name.strip).titleize
    end
    
    private
    def titleize_name
        self.first_name = self.first_name&.titleize
        self.last_name = self.last_name&.titleize
    end
    
    def join_address
        unless self.address.nil?
            address = self.address["street_address"] + ', ' + self.address["city"]  + ', ' +  self.address["province"]  + ' ' +  self.address["postal_code"]  + ', ' +  self.address["country"]
        end
    end
    
    def downcase_email!
        self.email&.downcase!
    end
    
end
