class TasksController < ::AuthenticatableController
  before_action :authenticate_user!
  def index
    if params[:farm_id]
      @user = User.find(params[:user_id])
      @farm = Farm.find(params[:farm_id])
      @tasks = @farm.tasks
    else
    	@user = User.find(params[:user_id])
      #TODO fix list task with authenticate
      @tasks = @user.assign_tasks
    end
  end

  def new
    @farm = Farm.find_by(id: params[:farm_id])
    @users = User.all
    @task = Task.new
  end

  def create
    @farm = Farm.find_by(id: params[:task][:farm_id])
    @task = Task.new(task_params)
    if params[:assignee_ids]
      @task.assignee_id = 0
      if @task.valid?
        @task.save_tasks(task_params, params[:assignee_ids])
        redirect_to user_farm_tasks_path(current_user.id, @farm.id)
      else
        render action: :new
      end
    else 
      if @task.save
      flash[:success] = "Created success"
      redirect_to user_tasks_path
      else
        render action: :new
      end
    end
  end

  def show
    @user = User.find(params[:user_id])
    @farm = Farm.find_by(id: params[:farm_id])
    @task = Task.find(params[:id])
    @task_master = true if @task.taskmaster_id == current_user.id
    @task_assignee = true if @task.assignee_id == current_user.id
  end

  def edit
  	@user = User.find(params[:user_id])
    @task = Task.find(params[:id])
  end

  def update
  	@user = User.find(params[:user_id])
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = "Task updated"
      redirect_to user_task_path @user, @task
    else
      render action: :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to user_tasks_path
  end

  private

  def task_params
    params.require(:task).permit Task::CREATE_COLUMNS_FOR_USERS
  end
end
