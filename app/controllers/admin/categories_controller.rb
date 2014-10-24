class Admin::CategoriesController < Admin::ApplicationController
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
  end

  def index
    @categories = Category.all
  end

  def show
  end

  private
    def category_params
      params.require(:category).permit(:name)
    end
end
