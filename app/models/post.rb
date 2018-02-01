class Post < ActiveRecord::Base
    #perform a "cascade delete", which ensures that when a post is deleted, 
    #all of its comments are too. Because When we delete a post, 
    #we also need to delete all related comments.
    has_many :comments, dependent: :destroy
end
