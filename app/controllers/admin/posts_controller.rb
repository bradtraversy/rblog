class Admin::PostsController < Admin::ApplicationController
  before_filter :verify_logged_in

  def new
    @page_title = 'Add Post';
    @post = Post.new
  end

  def create
    # Initialize model with attributes
    @post = Post.new(post_params)

    if params[:post][:image].blank?
      @post.image = nil
    end

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
 
    if params[:post][:image].blank?
      @post.image = nil
    end
    
    # Update in database
    if @post.update(post_params)
      # Create flash message
      flash[:notice] = "Post Updated"

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
    #@user = User.authenticate(params[:login][:username], params[:login][:password])
    if params[:search]
      @posts = Post.search(params[:search]).order("created_at DESC").paginate(:per_page => 10, :page => params[:page])
    else
      @posts = Post.all.order('created_at DESC').paginate(:per_page => 10, :page => params[:page])
    end
  end

  # Method to upload a file
  def upload(post_params)
     # Check if image was added
    if params[:post][:image].blank?
      # If no image was added
      @post.image = 'no-image.jpg'
    else
      # Get File Type
      file_type = params[:post][:image].content_type

      # Rename image using correct extension
       case file_type
         when "image/jpeg"
            file_name = "pic_#{Time.now.strftime("%Y%m%d%H%M%S")}.jpg"
         when "image/png"
            file_name = "pic_#{Time.now.strftime("%Y%m%d%H%M%S")}.png"
         when "image/gif"
            file_name = "pic_#{Time.now.strftime("%Y%m%d%H%M%S")}.gif"
         when "image/bmp"
            file_name = "pic_#{Time.now.strftime("%Y%m%d%H%M%S")}.bmp"
      end

      # Get posted image
      uploaded_io = params[:post][:image]

      # Upload File
      File.open(Rails.root.join('public', 'uploads', file_name), 'wb') do |file|
        file.write(uploaded_io.read)
      end

      # Assign image file name for database
      @post.image = file_name
    end
  end

  # Assign post parameters/attributes
  private
    def post_params
      params.require(:post).permit(:title, :category_id, :user_id, :tags, :body, :image)
    end
end
