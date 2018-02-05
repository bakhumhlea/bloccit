class SponsoredPost < ActiveRecord::Base
    belongs_to :topic
    has_many :comments
end
