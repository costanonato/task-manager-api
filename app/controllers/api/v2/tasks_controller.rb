class Api::V2::TasksController < Api::V2::BaseController
  before_action :authenticate_user!

  def index
		tasks = current_user.tasks.ransack(params[:q]).result
		render json: tasks, status: 200
  end

  def show
    task = current_user.tasks.find(params[:id])
    render json: task, status: 200
  end

  def create
    task = current_user.tasks.build(task_params)

    if task.save
      render json: task, status: 201
    else
      render json: { errors: task.errors }, status: 422
    end
  end

  def update
    task = current_user.tasks.find(params[:id])

    if task.update_attributes(task_params)
      render json: task, status: 200
    else
      render json: { errors: task.errors }, status: 422
    end
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy
    head 204
  end


  private

  def task_params
    params.require(:task).permit(:title, :description, :deadline, :done)
  end

end
