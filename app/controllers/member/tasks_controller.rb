class Member::TasksController < Member::BaseMemberController
  def index
    @tasks = current_user.assign_tasks
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = "Created success"
      redirect_to member_tasks_path
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
      redirect_to member_task_path @task
    else
      render action: :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
  	if @task.master == current_user
	    @task.destroy
      flash[:success] = "Task deleted success"
    else
      flash[:error] = "You don't have permit to delete this task."
    end
    redirect_to member_tasks_path
  end

  private

  def task_params
    params.require(:task).permit Task::CREATE_COLUMNS_FOR_MEMBERS
  end
end
