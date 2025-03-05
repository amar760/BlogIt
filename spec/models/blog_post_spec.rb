require 'rails_helper'

RSpec.describe BlogPost, type: :model do


  describe "Validations" do

    let!(:user) {create(:user)}

    it "is valid with valid attributes" do
      blog_post = create(:blog_post, user: user)
      expect(blog_post).to be_valid
    end

    it "is invalid without a title" do
      blog_post = BlogPost.new(description: "Test Description", user_id: user.id)
      expect(blog_post).to_not be_valid
    end

    it "is invalid without a description" do
      blog_post = BlogPost.new(title: "Test Title", user_id: user.id)
      expect(blog_post).to_not be_valid
    end
  end


  describe "Associations" do
    it "belongs to a user" do
      user = create(:user)
      blog_post = create(:blog_post, user: user)
      expect(blog_post.user).to eq(user)
    end
  end


  describe "Methods" do
    let!(:user) {create(:user)}

    it "should increments views" do
      blog_post = create(:blog_post, user: user)
      blog_post.increment_views
      expect(blog_post.views).to eq(1)
    end
  end

end
