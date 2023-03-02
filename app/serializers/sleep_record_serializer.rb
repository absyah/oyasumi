class SleepRecordSerializer
  include JSONAPI::Serializer
  belongs_to :user
  attributes :id, :user_id, :clock_in_at, :clock_out_at, :sleep_duration, :user
end
