class User < ActiveRecord::Base
    before_save { self.email = email.downcase if email.present? }
    validates :name, length: {minimum: 1, maximum: 100 }, presence: true
    validates :password, presence: true, length: { minimum: 8 }, if: "password_digest.nil?"
    validates :password, length: { minimum: 8 }, allow_blank: true
    # #5
    validates :email,
        presence: true,
        uniqueness: { case_sensitive: false },
        length: { minimum: 3, maximum: 254 }
    
    # #6
    has_secure_password
end
