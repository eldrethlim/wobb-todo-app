class API::V1::TasksController < API::BaseController
  before_action :authenticate_request

  def index
    tasks = current_api_user.tasks.order("created_at ASC")
    render(
      json: tasks, each_serializer: API::V1::TaskSerializer, status: 200
    )
  end

  def create
    task = current_api_user.tasks.create(task_params)

    if task.persisted?
      render(
        json: task, serializer: API::V1::TaskSerializer, status: 200
      )
    else
      render(
        json: { message: "Error creating task." }, status: 422
      )
    end
  end

  def complete
    task = Task.find_by(id: params[:task_id])
    task.update(complete: !task.complete)
    render(
      json: task, serializer: API::V1::TaskSerializer,
            meta: { message: "Task #{status(task)}" },
            status: 200
    )
  end

  private

  def task_params
    params.require(:task).permit(:description)
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
