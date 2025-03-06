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
    let!(:user) {create(:user)}
    
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

  describe "User Profile" do
    let!(:user) {create(:user)}

    it "should show the user profile" do
      post user_session_path, params: { user: { email: user.email, password: user.password } }
      get edit_user_registration_path(user)
      expect(response).to have_http_status(:success)
    end

    it "should update the user profile" do
      post user_session_path, params: { user: { email: user.email, password: user.password } }
      patch user_registration_path, params: { user: { email: "other@example.com", password: user.password, password_confirmation: user.password, current_password: user.password }}
      expect(response).to have_http_status(:redirect)
      expect(user.reload.email).to eq("other@example.com")
    end
  end


  describe "Delete User" do
    let!(:user) {create(:user)}

    it "should delete the user" do
      post user_session_path, params: { user: { email: user.email, password: user.password } }
      delete user_registration_path(user: { current_password: user.password })
      expect(response).to have_http_status(:redirect)
      expect(User.exists?(user.id)).to be_falsey
    end
  end


  describe "Protected Routes" do
    let!(:user) {create(:user)}
    let!(:blog_post) {create(:blog_post, user: user)}

    it "redirects to sign in page when accessing unauthenticated routes" do
      get edit_blog_post_url(blog_post.id)
      expect(response).to redirect_to(new_user_session_path)
    end
  end

end
