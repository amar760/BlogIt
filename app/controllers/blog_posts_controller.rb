class BlogPostsController < ApplicationController
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]  
  before_action :check_blog_post_owner, only: [:edit, :update, :destroy]

  def index
    @blog_posts = BlogPost.all
  end

  def show
  end

  def new
    @blog_post = current_user.blog_posts.build
  end

  def create
    @blog_post = current_user.blog_posts.build(blog_post_params)
    
    if @blog_post.save
      redirect_to @blog_post, notice: 'Blog post was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post, notice: 'Blog post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @blog_post.destroy
    redirect_to blog_posts_path, notice: 'Blog post was successfully deleted.'
  end

  private

  def set_blog_post
    @blog_post = BlogPost.find(params[:id])
  end

  def check_blog_post_owner
    unless @blog_post.user == current_user
      redirect_to blog_posts_path, alert: "You are not authorized to perform this action."
    end
  end

  def blog_post_params
    params.require(:blog_post).permit(:title, :description)
  end
end
