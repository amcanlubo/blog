class CategoriesController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_category, only: [:show, :edit, :update, :destroy]
  
  def index
    @categories = Category.all 
    @today = Task.where(task_date:Date.today)
    # @tasks = @category.tasks
    # @today = []
    # @categories.each do |category|
    # ttoday = Task.where(task_date:Date.today())
    # @today += ttoday if ttoday  
  end


  def show
    @category = Category.find(params[:id])
    @tasks = @category.tasks
  end


  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
        
        if @category.save
            redirect_to categories_path
            # redirect_to @category
            flash[:notice] = "Category was successfully created."
        else
            render :new
        end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
        redirect_to category_path(@category)
        flash[:notice] = "Category was successfully updated."
    else
        render :edit
    end 
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:notice] = "Category was successfully deleted."
    redirect_to categories_path
  end

  
  private
   
    def category_params
      params.require(:category).permit(:name)
    end
end
