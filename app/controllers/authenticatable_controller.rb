class AuthenticatableController < ApplicationController

  private

  # def authenticate_admin!
  #   authenticate_user!
  #   unless (cuc = current_user.class) == User
  #     redirect_to root_path, notice: "Please sign in."
  #   end
  # end

  def authenticate_admin!
    if signed_in?
      unless current_user.class == Admin
        redirect_to root_path, notice: "You do not have permission to access this page."
      end
    else
      redirect_to root_path, notice: "Please sign in."
    end
  end



  # def authenticate_admin!
  #   authenticate_user!
  #   unless (cuc = current_user.class) == Admin
  #     if cuc == Customer
  #       redirect_to root_path
  #     else
  #       redirect_to instance_eval("#{cuc.name.downcase}_root_path")
  #     end
  #   end
  # end

  # def authenticate_manager!
  #   authenticate_user!
  #   cuc = current_user.class
  #   unless cuc == Admin || cuc == Manager
  #     if cuc == Customer
  #       redirect_to root_path
  #     else
  #       redirect_to instance_eval("#{cuc.name.downcase}_root_path")
  #     end
  #   end
  # end

  # def authenticate_consultant!
  #   authenticate_user!
  #   if (cuc = current_user.class) == Customer
  #     redirect_to root_path
  #   end
  # end
end