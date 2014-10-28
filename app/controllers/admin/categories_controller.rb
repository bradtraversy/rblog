class Admin::CategoriesController < Admin::ApplicationController
  before_filter :verify_logged_in
  
  def new
    @page_title = 'Add Category';
    @category = Category.new
  end

  def create
    # Initialize model with attributes
    @category = Category.new(category_params)

    # Save in database
    if @category.save
      # Create flash message
      flash[:notice] = "Category successfully created"

      # Redirect to main resource page
      redirect_to admin_categories_path
    else
      # Show form again
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
 
    # Update in database
    if @category.update(category_params)
      # Create flash message
      flash[:notice] = "Category Updated"

      redirect_to admin_categories_path
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    # Create flash message
    flash[:notice] = "Category Removed"
 
    redirect_to admin_categories_path
  end

  def index
    if params[:search]
      @categories = Category.search(params[:search]).order("created_at DESC").paginate(:per_page => 10, :page => params[:page])
    else
      @categories = Category.all.order('created_at DESC').paginate(:per_page => 10, :page => params[:page])
    end
  end

  private
    def category_params
      params.require(:category).permit(:name)
    end
end
