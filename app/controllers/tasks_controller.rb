class TasksController < ApplicationController
  before_action :authenticate_user

  def index
    @tasks = current_user.tasks.order("created_at ASC")
  end

  def create
    task = current_user.tasks.create(task_params)

    if task.persisted?
      redirect_to(
        tasks_path,
        change: ['tasks', 'flash_messages'],
        flash: { success: "New task created" }
      )
    end
  end

  def complete
    task = Task.find_by(id: params[:task_id])
    task.update(complete: !task.complete)
    redirect_to(
      tasks_path,
      change: ['tasks','flash_messages'],
      flash: { success: "Task #{status(task)}"}
     )
  end

  private

  def task_params
    params.require(:task).permit(:description)
  end

  def authenticate_user
    redirect_to(root_path, flash: { danger: "Please Log In" }) unless current_user
  end

  def status(task)
    case task.complete
    when true
      "Completed"
    when false
      "Incompleted"
    end
  end
end
