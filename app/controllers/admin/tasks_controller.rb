class Admin::TasksController < Admin::BaseAdminController
	def index
    @tasks = Task.all
  end

  def new
    @users = User.all
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = "Created success"
      redirect_to admin_tasks_path
    else
      render action: :new
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = "Task updated"
      redirect_to admin_task_path @task
    else
      render action: :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to admin_tasks_path
  end

  private

  def task_params
    params.require(:task).permit Task::CREATE_COLUMNS_FOR_ADMINS
  end
end
