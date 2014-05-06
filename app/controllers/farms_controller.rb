class FarmsController < ::AuthenticatableController
  before_action :authenticate_user!
  def index
    @farms = current_user.farms
  end

  def new
    @user = User.find(params[:user_id])
    @parent_farm = Farm.find(params[:farm_id]) if params[:farm_id]

    @farm = Farm.new
    @parent_farm.position_in_farms.each do |position_in_farm|
      @farm.position_in_farms.build user_id: position_in_farm.user_id
    end
    # User.all.each do |user|
    #   @farm.position_in_farms.build user_id: user.id
    # end
  end

  def create
    @user = User.find(params[:user_id])
    @farm = Farm.new(farm_params)
    if @farm.save
      flash[:success] = "Created success"
      redirect_to user_farms_path 
    else
      binding.pry
      render action: :new 
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @farm = Farm.find(params[:id])
    binding.pry
    if @farm.parent_farm.present?
      @farm.parent_farm.position_in_farms.each do |position_in_parent_farm|
        flag = 0
        @farm.position_in_farms.each do |position_in_farm|
          if position_in_farm.user_id == position_in_parent_farm.user_id
            flag = 1
            position_in_farm.checked = true
          end
        end
        if flag == 0
          @farm.position_in_farms.build user_id: position_in_parent_farm.user_id, checked: false
        end
      end
    else
      # list users of child farm << parent farm
      @farm.position_in_farms.each do |position_in_farm|
        position_in_farm.checked = true
      end
      # all users
      # User.all.each do |user|
      #   @farm.position_in_farms.build user_id: user.id, checked: false
      # end
    end
  end

  def update
    @user = User.find(params[:user_id])
    @farm = Farm.find(params[:id])
    if request.xhr?
      other_user = User.find_by_email(params[:other_user_email])
      if other_user.present?
        unless PositionInFarm.find_position_by_user_id_and_farm_id(other_user.id, params[:id]).present? 
          PositionInFarm.create(user_id: other_user.id, farm_id: params[:id], position: 3)
          render partial: "form_edit_big_farm"
        else
          flash[:error] = "This member is exist in farm"
          render partial: "form_edit_big_farm"
        end
      else
        flash[:error] = "Account does not exist"
        render partial: "form_edit_big_farm"
      end
    else
      if @farm.update_attributes(farm_params)
        flash[:success] = "Task updated"
        redirect_to user_farm_path @user, @farm
      else
        render action: :edit
      end
    end
  end

  def show
    @user = User.find(params[:user_id])
    @farm = Farm.find(params[:id])
  end

  def destroy
    @farm = Farm.find(params[:id])
    @farm.destroy
    redirect_to user_farms_path
  end

  private

  def farm_params
    params.require(:farm).permit Farm::CREATE_COLUMNS_FOR_USERS
  end
end

