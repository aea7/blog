class CategoriesController < ApplicationController
before_action :require_admin, except: [:index, :show]

  def index
    @categories = Category.all
  end
  
  def show
    @category = Category.find(params[:id])
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:success] = "Name was updated"
      redirect_to category_path(@category)
    else
      render 'edit'
    end
      
  end
  
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Created the category"
      redirect_to categories_path
    else
      render 'new'
    end
  end
  
  private
  
  def require_admin 
    if !logged_in? || (logged_in? and !current_user.admin?) 
      flash[:danger] = "Only admins" 
      redirect_to categories_path
    end
  end
  
  def category_params
    params.require(:category).permit(:name)
  end
end
