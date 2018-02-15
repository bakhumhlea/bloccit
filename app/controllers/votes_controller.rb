class VotesController < ApplicationController
    
    before_action :require_sign_in
    
    def up_vote
        update_vote(1)
        redirect_to :back
    end
    def down_vote
        update_vote(-1)
        redirect_to :back
    end
    
    private
    
    def update_vote(new_value)
        if params[:post_id]
            @this_post = Post.find(params[:post_id])
        elsif params[:sponsored_post_id]
            @this_post = SponsoredPost.find(params[:sponsored_post_id])
        end
        @vote = @this_post.votes.where(user_id: current_user.id).first
        
        if @vote
            @vote.update_attribute(:value, new_value)
        else
            if params[:post_id]
                @vote = current_user.votes.create(value: new_value, post: @this_post)
            elsif params[:sponsored_post_id]
                @vote = current_user.votes.create(value: new_value, sponsored_post: @this_post)
            end
        end
    end
end
