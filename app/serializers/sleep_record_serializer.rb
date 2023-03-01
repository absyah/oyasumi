class SleepRecordSerializer
  include JSONAPI::Serializer
  attributes :id, :user_id, :clock_in_at, :clock_out_at, :sleep_duration
end
