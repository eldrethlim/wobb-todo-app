class API::V1::TasksSerializer < ActiveModel::Serializer
  attributes :id, :description, :complete
end
