class Admin::MembersController < Admin::BaseAdminController

  def edit
    @user = User.find(params[:id])
  end
  
	def update
    @user = User.find(params[:id])
    if @user.update_attributes(member_params)
      flash[:success] = "Profile updated"
      redirect_to admin_user_path @user
    else
      render action: :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def member_params
    params.require(:member).permit User::UPDATABLE_COLUMNS_FOR_ADMINS
  end
end
