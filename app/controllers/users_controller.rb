class UsersController < ApplicationController
  before_action :logged_in?

  def new
  end

  def create
    user = User.create(user_params)
    if user.persisted?
      session[:user_id] = user.id
      redirect_to(root_path, flash: { success: "User created" })
    else
      redirect_to(root_path, flash: { danger: "#{user.errors.full_messages}" })
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def logged_in?
    redirect_to tasks_path if current_user
  end
end
