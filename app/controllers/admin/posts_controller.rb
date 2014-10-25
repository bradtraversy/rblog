class Admin::PostsController < Admin::ApplicationController
  def new
    @page_title = 'Add Post';
    @post = Post.new
  end

  def create
    # Initialize model with attributes
    @post = Post.new(post_params)

    # Save in database
    if @post.save
      # Create flash message
      flash[:notice] = "Post successfully created"

      # Redirect to main resource page
      redirect_to admin_posts_path
    else
      # Show form again
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
 
    # Update in database
    if @post.update(post_params)
      # Create flash message
      flash[:notice] = "PostUpdated"

      redirect_to admin_posts_path
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    # Create flash message
    flash[:notice] = "Post Removed"
 
    redirect_to admin_posts_path
  end

  def index
    @posts = Post.all.order('created_at desc')
  end

  private
    def post_params
      params.require(:post).permit(:title, :category_id, :user_id, :tags, :body)
    end
end
