class API::V1::UsersController < API::BaseController
  def create
    user = User.create(user_params)
    if user.persisted?
      token = user.generate_auth_token
      render(
        json: { message: "User created", auth_token: token },
        status: 200
      )
    else
      render(
        json: { message: "#{user.errors.full_messages}" },
        status: 422
      )
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
