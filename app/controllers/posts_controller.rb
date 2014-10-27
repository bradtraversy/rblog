class PostsController < ApplicationController
  def index
  	@posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @categories = Category.all
  end
end
