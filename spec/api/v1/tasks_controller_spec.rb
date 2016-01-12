require 'rails_helper'

describe API::V1::TasksController do
  let!(:user) { create(:user) }
  let!(:task_one) { create(:task, user_id: user.id) }
  let!(:task_two) { create(:task, user_id: user.id) }
  let!(:token) { user.generate_auth_token }
  let!(:headers) { { Authorization: token } }

  describe "not authorized" do
    it "should response error" do
      get api_v1_tasks_path

      expect(response.status).to eql(401)
    end
  end

  describe "GET /api/v1/tasks" do
    it "should fetch tasks" do
      get api_v1_tasks_path, {}, headers
      data = JSON.parse(response.body)

      expect(response.status).to eql(200)
      expect(data["tasks"].count).to eql(2)
      expect(data["tasks"][0]["description"]).to eql(task_one.description)
      expect(data["tasks"][1]["description"]).to eql(task_one.description)
    end
  end

  describe "POST /api/v1/tasks" do
    it "should create tasks" do
      params = { task: { description: "Hello World" } }
      post api_v1_tasks_path, params, headers

      expect(response.status).to eql(200)
      expect(user.tasks.count).to eql(3)
      expect(user.tasks.last.description).to eql("Hello World")
    end
  end

  describe "POST /api/v1/tasks/:id/complete" do
    it "should complete task" do

      post api_v1_task_complete_path(task_one), {}, headers
      task = Task.find_by(id: task_one.id)
      data = JSON.parse(response.body)

      expect(response.status).to eql(200)
      expect(task.complete).to be(true)
      expect(data["task"]["id"]).to eql(task.id)
    end

    it "should incomplete task" do

      task_one.update(complete: true)
      post api_v1_task_complete_path(task_one), {}, headers
      task = Task.find_by(id: task_one.id)
      data = JSON.parse(response.body)

      expect(response.status).to eql(200)
      expect(task.complete).to be(false)
      expect(data["task"]["id"]).to eql(task.id)
    end
  end
end