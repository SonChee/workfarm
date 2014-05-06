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
      @tasks = Task.all
    end
  end

  def new
    @users = User.all
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = "Created success"
      redirect_to user_tasks_path
    else
      render action: :new
    end
  end

  def show
  	@user = User.find(params[:user_id])
    @task = Task.find(params[:id])
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
