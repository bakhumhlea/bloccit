class SponsoredPostsController < ApplicationController
  
  before_action :require_sign_in, except: :show
  before_action :authorize_moderator, only: [:edit, :update]
  before_action :authorize_user, except: [:show, :create, :new, :edit, :update]

  def show
    @sponsored_post = SponsoredPost.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @sponsored_post = SponsoredPost.new
  end
  
  def create
    @topic = Topic.find(params[:topic_id])
    @sponsored_post = SponsoredPost.new
    @sponsored_post.title = params[:sponsored_post][:title]
    @sponsored_post.body = params[:sponsored_post][:body]
    @sponsored_post.price = params[:sponsored_post][:price]
    @sponsored_post.topic = @topic
    @sponsored_post.user = current_user
    
    if @sponsored_post.save
      flash[:notice] = "Your new sponsored post was successfully saved"
      redirect_to [@topic, @sponsored_post]
    else
      flash.now[:alert] = "Error occured! Please try again."
      render :new
    end
  end

  def edit
    @sponsored_post = SponsoredPost.find(params[:id])
  end
  
  def update
    @sponsored_post = SponsoredPost.find(params[:id])
    @sponsored_post.title = params[:sponsored_post][:title]
    @sponsored_post.body = params[:sponsored_post][:body]
    @sponsored_post.price = params[:sponsored_post][:price]
    
    if @sponsored_post.save
      flash[:notice] = "Your sponsored post was updated"
      redirect_to [@sponsored_post.topic, @sponsored_post]
    else
      flash.now[:alert] = "Error occured! Please try again."
      render :edit
    end
  end
  def destroy
    @sponsored_post = SponsoredPost.find(params[:id])
    
    if @sponsored_post.destroy
      flash[:notice] = "\"#{@sponsored_post.title}\" was deleted successfully."
      redirect_to @sponsored_post.topic
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
    
  end
  
  private
  
  def authorize_user
    sponsored_post = SponsoredPost.find(params[:id])
    unless current_user == sponsored_post.user || current_user.admin?
      flash[:alert] = "Only admin can proceed that action!"
      redirect_to [sponsored_post.topic, sponsored_post]
    end
  end
  def authorize_moderator
    sponsored_post = Post.find(params[:id])
    unless current_user == sponsored_post.user || current_user.admin? || current_user.moderator?
      flash[:alert] = "Only admin can proceed that action!"
      redirect_to [sponsored_post.topic, sponsored_post]
    end
  end
end
