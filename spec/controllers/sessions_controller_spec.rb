require 'rails_helper'

describe SessionsController do
  describe "new session" do
    it "should render new" do
      get :new

      expect(response).to render_template("new")
    end
  end

  describe "create session" do
    let!(:user) { create(:user) }
    it "should set user session" do
      params = { user: { email: user.email, password: "password" } }
      post :create, params: params

      expect(response).to redirect_to(tasks_path)
      expect(session[:user_id]).to eql(user.id)
    end
  end

  describe "destroy session" do
    let!(:user) { create(:user) }

    it "should destroy user session" do
      params = { user: { email: user.email, password: "password" } }
      post :create, params: params

      expect(session[:user_id]).to eql(user.id)

      params = { id: user.id }
      delete :destroy, params: params

      expect(response).to redirect_to(root_path)
      expect(session[:user_id]).to be(nil)
    end
  end
end
