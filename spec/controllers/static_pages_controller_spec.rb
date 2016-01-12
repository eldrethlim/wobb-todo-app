require 'rails_helper'

describe StaticPagesController do
  describe "get index" do
    it "should render index" do
      get :index

      expect(response).to render_template("index")
    end
  end
end
