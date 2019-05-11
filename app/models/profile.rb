class Profile < ApplicationRecord
    has_secure_password
    belongs_to :user
    validates :email, presence: true, uniqueness: true, format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

    validates :first_name, :last_name, presence: true
    def full_name
        self.first_name.strip.concat(' ', self.last_name.strip).titleize
    end
end
