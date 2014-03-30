class PostsController < ApplicationController
  def index
    @posts = Post.all
    @comments = Comment.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
  end
end
