class RemoveLikedByFromBlogPosts < ActiveRecord::Migration[7.2]
  def change
    remove_column :blog_posts, :liked_by, :integer
  end
end
