require 'rails_helper'

describe TasksController do
  describe "GET index" do
    let!(:user) { create(:user) }
    let!(:task_one) { create(:task, user_id: user.id) }
    let!(:task_two) { create(:task, user_id: user.id) }

    it 'should fetch tasks' do
      get :index, params: nil, session: { user_id: user.id }

      expect(response).to render_template("index")
      expect(assigns(:tasks).count).to eql(2)
      expect(assigns(:tasks).first.description).to eql(task_one.description)
      expect(assigns(:tasks).last.description).to eql(task_two.description)
    end
  end

  describe "create task" do
    let(:user) { create(:user) }

    it 'should create task' do

      params = { task: { description: "lorem ipsum" } }
      post :create, params: params, session: { user_id: user.id }
      expect(user.tasks.count).to eql(1)
      expect(user.tasks.first.description).to eql(params[:task][:description])
    end
  end

  describe "complete/incomplete task" do
    let!(:user) { create(:user) }
    let!(:task_one) { create(:task, user_id: user.id) }
    let!(:task_two) { create(:task, :complete, user_id: user.id) }

    it 'should complete task' do
      params = { task_id: task_one.id }
      post :complete, params: params, session: { user_id: user.id }

      expect(user.tasks.find_by(id: task_one.id).complete).to be(true)
    end

    it 'should incomplete task' do
      params = { task_id: task_two.id }
      post :complete, params: params, session: { user_id: user.id }

      expect(user.tasks.find_by(id: task_two.id).complete).to be(false)
    end
  end
end
