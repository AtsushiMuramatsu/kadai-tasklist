class TasksController < ApplicationController
  before_action :set_shigoto, only: [:show, :edit, :update, :destroy]
  def index
    if logged_in?
      @task = current_user.tasks.build  # form_with 用
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
    end
  end
  
  def show
  end

  def new
      @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスク が正常に登録されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスク が登録されませんでした'
      render :new
    end
  end

  def edit
  end

  def update

    if @task.update(task_params)
      flash[:success] = 'タスク は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスク は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy

    flash[:success] = 'タスク は正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
    def set_shigoto
     @task = Task.find(params[:id])
    end

  # Strong Parameter
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
end
