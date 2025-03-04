require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "Registration" do
    it "should creates a new user with valid attributes" do
      expect {
        post user_registration_path, params:{ user: {email: "test@example.com", password: "password"}}
      }.to change(User, :count).by(1)
      expect(response).to have_http_status(:redirect)
    end

    it "should not create a new user with invalid attributes" do
      expect {
        post user_registration_path, params:{ user: {email: "test@example.com"}}
      }.to_not change(User, :count)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end


  describe "Login" do
    let!(:user) {User.create(email: "test@example.com", password: "password")}
    
    it "should log in a user with valid credentials" do
      post user_session_path, params: {user: {email: "test@example.com", password: "password"}}
      expect(response).to have_http_status(:redirect)
      expect(controller.current_user).to eq(user)
    end

    it "should not log in a user with invalid credentials" do
      post user_session_path, params: {user: {email: "test@example.com", password: "wrong_password"}}
      expect(response).to have_http_status(:unprocessable_entity)
      expect(controller.current_user).to be_nil
    end
  end

  describe "Logout" do
    it "should log out a user" do
      post user_session_path, params: { user: { email: "test@example.com", password: "password123" } }
      delete destroy_user_session_path
      expect(response).to have_http_status(:redirect)
      expect(controller.current_user).to be_nil
    end
  end


  describe "Protected Routes" do
    let!(:user) {User.create(email: "test@example.com", password: "password")}
    let!(:blog_post) {BlogPost.create(title: "Test Post", description: "Test Body", user_id: user.id)}

    it "redirects to sign in page when accessing unauthenticated routes" do
      get edit_blog_post_url(1)
      expect(response).to redirect_to(new_user_session_path)
    end
  end

end
