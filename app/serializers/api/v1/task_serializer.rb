class API::V1::TaskSerializer < ActiveModel::Serializer
  attributes :id, :description, :complete
end
