class Admin::UsersController < ApplicationController
  before_action :signed_in_user, :new, :edit, :update, :show
  before_action :correct_user,   only: [:edit, :update]
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

  def show
    @user = User.find(params[:id])
  end

  private

    def user_params
      params.require(:user).permit(:code, :first_name, :last_name, :email, :password,
                                   :password_confirmation)
    end

    # Before filters

    def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
