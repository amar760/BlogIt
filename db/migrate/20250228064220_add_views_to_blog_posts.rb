class AddViewsToBlogPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :blog_posts, :views, :integer, default: 0
  end
end
