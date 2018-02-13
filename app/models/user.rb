class User < ActiveRecord::Base
    has_many :posts
    has_many :sponsored_posts
    
    before_save { self.name = name.split(' ').each{|w| w.capitalize! }.join(' ') if name.present? }
    before_save { self.email = email.downcase if email.present? }
    before_save { self.role ||= :member }
    
    validates :name, length: {minimum: 1, maximum: 100 }, presence: true
    validates :password, presence: true, length: { minimum: 8 }, if: "password_digest.nil?"
    validates :password, length: { minimum: 8 }, allow_blank: true
    
    validates :email,
        presence: true,
        uniqueness: { case_sensitive: false },
        length: { minimum: 3, maximum: 254 }
    
    has_secure_password
    
    enum role: [:member, :admin, :moderator]
end
