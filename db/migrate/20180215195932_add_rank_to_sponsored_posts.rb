class AddRankToSponsoredPosts < ActiveRecord::Migration
  def change
    add_column :sponsored_posts, :rank, :float
  end
end
