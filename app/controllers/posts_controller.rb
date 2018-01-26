class PostsController < ApplicationController
  def index
    screen_posts = Post.all
    #screening sensitive post
    screen_posts.each_with_index {|p,i| p.title = "SPAM" if i==0 || (i+1)%5==0 }
    @posts = screen_posts
  end

  def show
  end

  def new
  end

  def edit
  end
end
