class AddUserToSponsoredPosts < ActiveRecord::Migration
  def change
    add_column :sponsored_posts, :user_id, :integer
    add_index :sponsored_posts, :user_id
  end
end
