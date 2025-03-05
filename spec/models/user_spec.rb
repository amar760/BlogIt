require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Validations" do
    it "is valid with valid email and password" do
      user = create(:user) 
      expect(user).to be_valid
      expect(User.count).to eq(1)
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
      create(:user)
      user = User.new(email: "test@example.com", password: "password")
      expect(user).to_not be_valid
      expect(User.count).to eq(1)
    end
  end


  describe "Associations" do
    it "has many blog posts" do
      user = create(:user)
      blog_post1 = create(:blog_post, title: "Test Blog Post", description: "Test Description", user: user)
      blog_post2 = create(:blog_post, title: "Test Blog Post 2", description: "Test Description 2", user: user)
      expect(user.blog_posts).to include(blog_post1, blog_post2)
    end
  end
  
end
