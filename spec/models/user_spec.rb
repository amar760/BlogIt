require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Validations" do
    it "is valid with valid email and password" do
      user = User.new(email: "test@example.com", password: "password")
      expect(user).to be_valid
      expect(User.count).to eq(0)
    end

    it "is invalid without an email" do
      user = User.new(password: "password")
      expect(user).to_not be_valid
      expect(User.count).to eq(0)
    end

    it "is invalid without a password" do
      user = User.new(email: "test@example.com")
      expect(user).to_not be_valid
      expect(User.count).to eq(0)
    end

    it "is invalid with invalid email format" do
      user = User.new(email: "invalid-email", password: "password")
      expect(user).to_not be_valid
      expect(User.count).to eq(0)
    end

    it "is invalid with a duplicate email" do
      User.create(email: "test@example.com", password: "password")
      user = User.new(email: "test@example.com", password: "password")
      expect(user).to_not be_valid
      expect(User.count).to eq(1)
    end
  end


  describe "Associations" do
    it "has many blog posts" do
      user = User.create(email: "test@example.com", password: "password")
      blog_post1 = user.blog_posts.create(title: "Test Blog Post", description: "Test Description")
      blog_post2 = user.blog_posts.create(title: "Test Blog Post 2", description: "Test Description 2")
      expect(user.blog_posts).to include(blog_post1, blog_post2)
    end
  end
  
end
