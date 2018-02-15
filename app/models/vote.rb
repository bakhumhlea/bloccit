class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  belongs_to :sponsored_post
  after_save :update_post
  
  validates :value, inclusion: { in: [-1, 1], message: "%{value} is not a valid vote." }, presence: true
  
  private
  
  def update_post
    if post.nil? == false
      post.update_rank
    else
      sponsored_post.update_rank
    end
  end
end
