class SessionsController < ApplicationController
	def new
    if signed_in?
      redirect_to root_url, notice: "You signed in"
    end
  end

  def create
    binding.pry
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #TODO authenticate and redirect
      sign_in user
      if current_user.class == Admin
        redirect_to admin_user_path user
      else
        if current_user.class == Member
          redirect_to member_tasks_path
        else
          redirect_to root_url
        end
      end
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
