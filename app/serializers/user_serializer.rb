class UserSerializer
  include JSONAPI::Serializer
  has_many :sleep_records
  attributes :id, :name
end
