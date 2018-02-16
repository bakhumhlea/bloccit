class TopicsController < ApplicationController
    
    before_action :require_sign_in, except: [:index, :show]
        #translate: before any :action do 'require_sign_in' method except :index and :show action
        #if guest users try to do actions
    before_action :authorize_moderator, only: [:edit, :update]
    before_action :authorize_user, except: [:index, :show, :edit, :update, :destroy]
        #translate: before any :action do 'authorize_user' method except :index and :show action
        #if non-admin try to do actions
    
    def index
        @topics = Topic.all
    end
    
    def show
        @topic = Topic.find(params[:id])
        
        if params[:order] == 'by_title'
            Post.unscoped { Post.ordered_by_title }
        elsif @post == 'by_oldest_post'
            Post.unscoped { Post.ordered_by_reverse_created_at }
        else
            @topic.posts
        end
    end
    
    def new
       @topic = Topic.new
    end
    
    def create
        @topic = Topic.new(topic_params)
        
        if @topic.save
            redirect_to @topic, notice: "Topic was saved successfully."
        else
            flash.now[:alert] = "Error creating topic. Please try again."
            render :new
        end
    end
    
    def edit
        @topic = Topic.find(params[:id])
    end
    
    def update
        @topic = Topic.find(params[:id])
        
        @topic.assign_attributes(topic_params)
        
        if @topic.save
            flash[:notice] = "Topic was updated."
            redirect_to @topic
        else
            flash.now[:alert] = "Error saving topic. Please try again."
            render :edit
        end
    end
    
    def destroy
        @topic = Topic.find(params[:id])
     
        if @topic.destroy
            flash[:notice] = "\"#{@topic.name}\" was deleted successfully."
            redirect_to action: :index
        else
            flash.now[:alert] = "There was an error deleting the topic."
            render :show
        end
    end

    private
    
    def topic_params
        params.require(:topic).permit(:name, :description, :public)
    end
    
    def authorize_user
        topic = Topic.find(params[:id])
        unless current_user.admin?
            flash[:alert] = "Only admin can do that!"
            redirect_to topic
        end
    end
    
    def authorize_moderator
        topic = Topic.find(params[:id])
        unless current_user.admin? || current_user.moderator?
            flash[:alert] = "Only admin can do that!"
            redirect_to topic
        end
    end
    
end
