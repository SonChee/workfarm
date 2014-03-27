class Admin::AdminsController < Admin::BaseAdminController
before_action :correct_user,   only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to admin_user_path @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:admin).permit(:type, :code, :first_name, :last_name, :email, :password,
                                   :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path, notice: "You do not have permission to access this page." unless current_user?(@user)
    end
end
