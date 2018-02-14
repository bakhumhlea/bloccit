class Post < ActiveRecord::Base
    belongs_to :topic
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :votes, dependent: :destroy
    
    ##The default_scope will order all posts by their created_at date, in descending order(DESC)
    default_scope { order('created_at DESC') }
    
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
end
