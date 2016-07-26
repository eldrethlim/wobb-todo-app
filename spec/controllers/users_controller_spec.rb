require 'rails_helper'

describe UsersController do
  describe "new user" do
    it "should render new" do
      get :new

      expect(response).to render_template("new")
    end
  end

  describe "create user" do
    it "should create user" do
      params = { user: { first_name: "foo", last_name: "bar", email: "user@gmail.com", password: "password", password_confirmation: "password" }}
      post :create, params: params

      user = User.first

      expect(response).to redirect_to(root_path)
      expect(User.all.count).to eql(1)
      expect(user.email).to eql("user@gmail.com")
      expect(user.first_name).to eql("foo")
      expect(user.last_name).to eql("bar")
      expect(session[:user_id]).to eql(user.id)
    end
  end
end
