class BlogPost < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true

  def increment_views
    update_column(:views, views + 1)
  end

end
