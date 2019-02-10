class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :edit, :show]
  
  # createが失敗したときにページ更新をした場合の対策
  def index
    redirect_to root_url
  end
  
  def edit
  end
  
  # updateが失敗したときにページ更新をした場合の対策
  def show
    redirect_to edit_task_path(@task)
  end
  
  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'タスクは正常に更新されませんでした。'
      render 'edit'
    end
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'Task が投稿されませんでした'
      
      @tasks = current_user.tasks.order('created_at').page(params[:page])
      render 'toppages/index'
    end
  end
  
  def destroy
    @task.destroy
    flash[:success] = 'Task は正常に削除されました'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
