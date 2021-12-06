class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :get_category, except: [:today]
  before_action :set_task, only: %i[ show edit update destroy ]
  
  def index
    @tasks = @category.tasks
  end

  
  def show
    # @task = Task.find(params[:id])
    @task = @category.tasks.find(params[:id])
  end

  
  def new
    @task = @category.tasks.build
  end

  # GET /tasks/1/edit
  def edit
 
    @task = @category.tasks.find(params[:id])
  end

  # POST /tasks or /tasks.json
  def create

    # byebug
    @task = @category.tasks.build(task_params)

     
    respond_to do |format|

      if @task.save
    #     # format.html { redirect_to @task, notice: "Task was successfully created." }
        format.html { redirect_to category_tasks_path(@category.id), notice: "Task was successfully created" }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end


  def update

    @task = Task.find(params[:id])
    
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to category_task_path(@category.id, @task.id), notice: "Task was successfully updated" }
        # format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        # format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    # @task = @category.tasks.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to category_path(@category.id), notice: "Task was successfully deleted" }
      format.json { head :no_content }
    end
  end

  def today
    @tasks = Task.where(task_date:Date.today)
    # task.task_date == Date.today
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    def get_category
      @category = Category.find(params[:category_id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:category_id, :name, :body, :task_date)
    end
end
