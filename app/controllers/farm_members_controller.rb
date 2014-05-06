class FarmMembersController < ::AuthenticatableController
  before_action :authenticate_user!
	def index
    @farm = Farm.find(params[:farm_id])
  end

  def new
    @users = User.all
    @farm = Farm.find(params[:farm_id])
  end
end
