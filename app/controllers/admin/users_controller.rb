class Admin::UsersController < Admin::BaseAdminController
  # before_action :signed_in_user, :new, :edit, :update, :show
  before_action :correct_user,   only: [:edit, :update, :destroy]
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Created success"
      redirect_to admin_user_path @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  private

    def user_params
      params.require(:user).permit User::CREATE_COLUMNS_FOR_ADMINS
    end


    # Before filters

    # def signed_in_user
    #   redirect_to signin_url, notice: "Please sign in." unless signed_in?
    # end

    def correct_user
      @user = User.find(params[:id])
      # redirect_to root_path, notice: "You do not have permission." unless @user == "Admin" || @user == "Member"
    end
end
