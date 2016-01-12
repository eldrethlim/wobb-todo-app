class API::V1::TasksController < API::BaseController
  before_action :authenticate_request

  def index
    tasks = current_api_user.tasks.order("created_at ASC")
    render(
      json: tasks, each_serializer: API::V1::TasksSerializer, status: 200
    )
  end

  def create
    task = current_api_user.tasks.build(task_params)

    if task.persisted?
      render(
        json: task, serializer: API::V1::TasksSerializer, status: 200
      )
    else
      render(
        json: { message: "Error creating task." }, status: 422
      )
    end
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
