require 'rails_helper'

RSpec.describe "BlogPostsControllers", type: :request do

  describe "GET /blog_posts" do
    it "should return a list of blog posts" do
      get blog_posts_path
      expect(response).to have_http_status(:success)
    end

    it "should return a list of blog posts for a specific user" do
      user = User.create(email: "test@example.com", password: "password")
      blog_post = BlogPost.create(title: "Test Post", description: "Test Body", user: user)
      get blog_posts_path(user: user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /blog_posts/:id" do
    it "should return a single blog post" do
      user = User.create(email: "test@example.com", password: "password")
      blog_post = BlogPost.create(title: "Test Post", description: "Test Body", user: user)
      get blog_post_path(blog_post)
      expect(response).to have_http_status(:success)
      expect(response.body).to include(blog_post.title)
    end
  end


  describe "GET /blog_posts/new" do
    it "should return a new blog post form" do
      user = User.create(email: "test@example.com", password: "password")
      user_session_path user
      get new_blog_post_path
      expect(response).to have_http_status(:redirect)
    end

    it "should not return a new blog post form for unauthenticated users" do
      get new_blog_post_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "POST /blog_posts" do

    it "should create a new blog post" do
      user = User.create(email: "test@example.com", password: "password")
     
      post user_session_path, params: { user: {email: user.email, password: user.password} }
      post blog_posts_path, params: { blog_post: { title: "Test Post", description: "Test Body", user_id: user.id } }
     
      expect(controller.current_user).to eq(user)
      expect(response).to redirect_to(blog_post_path(BlogPost.last))
      expect(BlogPost.last.title).to eq("Test Post")
      expect(BlogPost.last.description).to eq("Test Body")
      expect(BlogPost.last.user).to eq(user)
    end

    it "should stay on the new blog post form if the blog post is not valid" do
      user = User.create(email: "test@example.com", password: "password")
     
      post user_session_path, params: { user: {email: user.email, password: user.password} }
      post blog_posts_path, params: { blog_post: { title: "Test Post", user_id: user.id } }

      expect(response).not_to have_http_status(:redirect)
    end
  end



  describe "GET /blog_posts/:id/edit" do
    let!(:user) {User.create(email: "test@example.com", password: "password")}
    let!(:blog_post) {BlogPost.create(title: "Test Post", description: "Test Body", user: user)}

    it "should return the edit form for a blog post" do
      post user_session_path, params: { user: {email: user.email, password: user.password} }

      get edit_blog_post_path(blog_post)
      expect(response).to have_http_status(:success)
      expect(response.body).to include(blog_post.title)
    end

    it "should redirect to the sign in page if the user is not signed in" do
      get edit_blog_post_path(blog_post)
      expect(response).to redirect_to(new_user_session_path)
    end
  end



  describe "PUT /blog_posts/:id" do
    let!(:user) {User.create(email: "test@example.com", password: "password")}
    let!(:blog_post) {BlogPost.create(title: "Test Post", description: "Test Body", user: user)}

    it "should update a blog post" do
      post user_session_path, params: { user: {email: user.email, password: user.password} }
      put blog_post_path(blog_post), params: { blog_post: { title: "Updated Post", description: "Updated Body" } }
      expect(response).to redirect_to(blog_post_path(blog_post))
      expect(blog_post.reload.title).to eq("Updated Post")
      expect(blog_post.reload.description).to eq("Updated Body")
    end

    it "should stay on the edit form if the blog post is not valid" do
      post user_session_path, params: { user: {email: user.email, password: user.password} }
      put blog_post_path(blog_post), params: { blog_post: { title: "Updated Post", description: "" } }
      expect(response).not_to have_http_status(:redirect)
    end

    it "should not be editable by other users" do
      other_user = User.create(email: "other@example.com", password: "password")
      post user_session_path, params: { user: {email: other_user.email, password: other_user.password} }
      put blog_post_path(blog_post), params: { blog_post: { title: "Updated Post", description: "Updated Body" } }
      expect(response).to redirect_to(blog_posts_path)
    end
  end



  describe "DELETE /blog_posts/:id" do
    let!(:user) {User.create(email: "test@example.com", password: "password")}
    let!(:blog_post) {BlogPost.create(title: "Test Post", description: "Test Body", user: user)}

    it "should delete a blog post" do
      post user_session_path, params: { user: {email: user.email, password: user.password} }

      delete blog_post_path(blog_post)
      expect(response).to redirect_to(blog_posts_path)
      expect(BlogPost.count).to eq(0)
    end

    it "should not be deletable by other users" do
      other_user = User.create(email: "other@example.com", password: "password")
      post user_session_path, params: { user: {email: other_user.email, password: other_user.password} }
      delete blog_post_path(blog_post)
      expect(response).to redirect_to(blog_posts_path)
    end
  end
end
