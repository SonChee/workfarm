class Admin::FarmsController < Admin::BaseAdminController
  def index
    @big_farms = Farm.big_farms
  end	

  def new
    @farm = Farm.new
    User.all.each do |user|
      @farm.position_in_farms.build user_id: user.id
    end
  end

  def create
    @farm = Farm.new(farm_params)
    if @farm.save
      flash[:success] = "Created success"
      redirect_to admin_farms_path 
    else
      render action: :new 
    end
  end

  def show
    @big_farm = Farm.find(params[:id])
    @big_farm_managers = PositionInFarm.find_big_farm_managers_by_farm_id(params[:id])
  end

  private

  def farm_params
    params.require(:farm).permit Farm::CREATE_COLUMNS_FOR_USERS
  end
end
