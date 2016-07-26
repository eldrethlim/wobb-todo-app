require 'rails_helper'

describe API::V1::SessionsController do
  describe "create session" do
    let!(:user) { create(:user) }
    it "should provide token" do
      params = { user: { email: user.email, password: "password" } }
      post api_v1_sessions_path, params: params

      auth_token = JSON.parse(response.body)["auth_token"]
      data = AuthTokenService.decode(auth_token)
      expect(auth_token).to be_truthy
      expect(data["user_id"]).to eql(user.id)
    end
  end
end
