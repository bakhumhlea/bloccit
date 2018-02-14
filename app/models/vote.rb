class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  belongs_to :sponsored_post
  
  validates :value, inclusion: { in: [-1, 1], message: "%{value} is not a valid vote." }, presence: true
end
