class Post < ActiveRecord::Base
    belongs_to :topic
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :votes, dependent: :destroy
    has_many :favorites, dependent: :destroy
    
    after_create :create_vote
    after_create :mark_favorite
    
    ##The default_scope will order all posts by their created_at date, in descending order(DESC)
    default_scope { order('rank DESC') }
    
    def self.ordered_by_title
        order('title ASC')
    end
    
    def self.ordered_by_reverse_created_at
        order('created_at ASC')
    end
    
    #validating posts
    validates :title, length: { minimum: 5 }, presence: true
    validates :body, length: { minimum: 20 }, presence: true
    validates :topic, presence: true
    validates :user, presence: true
    
    def up_votes
        votes.where(value: 1).count
    end
    
    def down_votes
        votes.where(value: -1).count
    end
    
    def points
        votes.sum(:value)
    end
    
    def update_rank
        age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
        new_rank = points + age_in_days
        update_attribute(:rank, new_rank)
    end
    
    def create_vote
        user.votes.create!(value: 1, post: self )
    end
    
    private
    
    def mark_favorite
        user = self.user
        Favorite.create!(post: self, user: user)
        FavoriteMailer.new_post(user, self).deliver_now
    end
end
