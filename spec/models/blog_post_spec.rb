require 'rails_helper'

RSpec.describe BlogPost, type: :model do


  describe "Validations" do

    let!(:user) {User.create(email: "test@example.com", password: "password")}

    it "is valid with valid attributes" do
      blog_post = BlogPost.new(title: "Test Title", description: "Test Description", user_id: user.id)
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
      user = User.create(email: "test@example.com", password: "password")
      blog_post = user.blog_posts.create(title: "Test Title", description: "Test Description")
      expect(blog_post.user).to eq(user)
    end
  end


  describe "Methods" do
    let!(:user) {User.create(email: "test@example.com", password: "password")}

    it "should increments views" do
      blog_post = BlogPost.create(title: "Test Title", description: "Test Description", user_id: user.id)
      blog_post.increment_views
      expect(blog_post.views).to eq(1)
    end
  end

end
