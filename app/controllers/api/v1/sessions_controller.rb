class API::V1::SessionsController < API::BaseController

  def create
    user = User.find_by_credentials(user_params[:email], user_params[:password])
    if user
      token = user.generate_auth_token
      render(
        json: { message: "User created", auth_token: token },
        status: 200
      )
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
