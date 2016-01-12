class SessionsController < ApplicationController
  before_action :logged_in?, except: [:destroy]

  def new
  end

  def create
    user = User.find_by_credentials(user_params[:email], user_params[:password])
    if user
      session[:user_id] = user.id
      redirect_to(tasks_path, flash: { success: "Logged In"})
    else
      redirect_to(root_path, flash: { danger: "Invalid Credentials"})
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to(root_path, flash: { success: "Logged Out" })
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def logged_in?
    redirect_to tasks_path if current_user
  end
end
