class AddSponsoredPostToVotes < ActiveRecord::Migration
  def change
    add_reference :votes, :sponsored_post, index: true, foreign_key: true
  end
end
