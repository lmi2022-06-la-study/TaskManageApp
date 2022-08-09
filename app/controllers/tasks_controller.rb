class TasksController < ApplicationController
  before_action :require_signed_in
  before_action :set_task, only: [:edit, :update, :destroy, ]
  before_action :correct_user, only: [:edit, :update, :destroy, ]

  
  # indexはいらん
  
  def edit
    # @task = Task.find(params[:id])
  end
    # def new
  #   @task = Task.new
  # end

  def update
    # @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:success] = "更新しました"
      redirect_to root_path
    else
      flash.now[:danger] = "更新失敗"
      render "users/show"
    end

  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = "作成しました"
      redirect_to root_path
    else
      flash.now[:danger] = "作成失敗"
      render root_path
    end
  end
  def destroy
    # @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = "削除しました"
    redirect_to root_path
  end

  # 一括削除
  def refresh_done
    # done
    @done = current_user.tasks.where(status: 2)
    @done.destroy_all
    flash[:success] = "削除しました"
    redirect_to root_path
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:name, :status)
  end
  def correct_user
    unless @task.user_id == current_user.id
      flash[:danger] = "編集できません"
      redirect_to root_path
    end
  end
end
