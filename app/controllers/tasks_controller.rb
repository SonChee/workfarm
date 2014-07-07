class TasksController < ::AuthenticatableController
  before_action :authenticate_user!
  def index
    if params[:farm_id]
      @user = User.find(params[:user_id])
      @farm = Farm.find(params[:farm_id])
      @q = @farm.tasks.search params[:q]
      @q.build_sort if @q.sorts.empty?
      @tasks = @q.result.order_by_created_at.paginate page: params[:page] , per_page: 15
    else
    	@user = User.find(params[:user_id])
      #TODO fix list task with authenticate
      @q = @user.assign_tasks.search params[:q]
      @q.build_sort if @q.sorts.empty?
      @tasks = @q.result.order_by_created_at.paginate page: params[:page] , per_page: 15
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
        flash[:success] = "Created tasks success"
        @task.save_tasks(task_params, params[:assignee_ids])
        redirect_to user_farm_tasks_path(current_user.id, @farm.id)
      else
        render action: :new
      end
    else 
      if @task.save
      flash[:success] = "Created task success"
      redirect_to user_task_path(current_user, @task)
      else
        render action: :new
      end
    end
  end

  def show
    @task = Task.find(params[:id])
    @user = User.find(params[:user_id])
    @farm = Farm.find_by(id: params[:farm_id])
    @task_master = true if @task.taskmaster_id == current_user.id
    @task_assignee = true if @task.assignee_id == current_user.id
    if @farm.present?
      @farm_user = true if @farm.users.include? current_user
    end
    if @task.try(:farm).try(:leaders)
      @farm_leader = true if @task.try(:farm).try(:leaders).include? current_user
    end
    if request.xhr?
      if params[:submit_edit_comment].present?
        comment = Comment.find(params[:comment_id])
        comment.update_attributes(comment: params[:comment])
        render partial: "comment", locals: { comment: comment }
      else
        if params[:cancel_edit_comment].present?
          comment = Comment.find(params[:comment_id])
          render partial: "comment", locals: { comment: comment }
        else
          if params[:edit_comment].present?
            comment = Comment.find(params[:comment_id])
            render partial: "edit_comment", locals: { comment: comment }
          else
            comment = Comment.new(user_id: params[:user_id], task_id: params[:id], comment: params[:comment])
            if comment.valid?
              comment.save
            end
            render partial: "tb_comment"
          end
        end
      end
    end
  end

  def edit
  	@user = User.find(params[:user_id])
    @task = Task.find(params[:id])
    @farm = Farm.find_by(id: params[:farm_id])
    if @task.try(:farm).try(:leaders)
      @farm_leader = true if @task.try(:farm).try(:leaders).include? current_user
    end
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
