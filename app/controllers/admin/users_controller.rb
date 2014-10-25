class Admin::UsersController < Admin::ApplicationController
  def new
    @page_title = 'Add User';
    @user = User.new
  end

  def create
    # Initialize model with attributes
    @user = User.new(user_params)

    # Save in database
    if @user.save
      # Create flash message
      flash[:notice] = "User successfully created"

      # Redirect to main resource page
      redirect_to admin_users_path
    else
      # Show form again
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
 
    # Update in database
    if @user.update(user_params)
      # Create flash message
      flash[:notice] = "Category Updated"

      redirect_to admin_users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    # Create flash message
    flash[:notice] = "User Removed"
 
    redirect_to admin_users_path
  end

  def index
    @users = User.all.order('created_at desc')
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end