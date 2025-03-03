class BlogPost < ApplicationRecord
  belongs_to :user

  has_many :likes
  has_many :likers, through: :likes, source: :user
  
  validates :title, presence: true
  validates :description, presence: true

  def increment_views
    update_column(:views, views + 1)
  end

end
