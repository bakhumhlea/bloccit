class AddTopicToSponsoredPosts < ActiveRecord::Migration
  def change
    add_reference :sponsored_posts, :topic, index: true, foreign_key: true
  end
end
