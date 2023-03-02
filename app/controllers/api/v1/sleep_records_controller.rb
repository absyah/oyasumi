module Api
  module V1
    class SleepRecordsController < Api::BaseController
      # curl GET http://localhost:3000/api/v1/users/sleep_records -u "id:name"
      def index
        sleep_records = current_user.sleep_records.completed
        render json: SleepRecordSerializer.new(sleep_records)
      end

      # curl -H "Content-Type: application/json" -X POST http://localhost:3000/api/v1/clock_in -u "id:name"
      def clock_in
        # returns clocked-in sleep record
        render json: SleepRecordSerializer.new(current_user.clock_in!)
      end

      # curl -H "Content-Type: application/json" -X POST http://localhost:3000/api/v1/clock_out -u "id:name"
      def clock_out
        # returns clocked-out sleep record
        render json: SleepRecordSerializer.new(current_user.clock_out!)
      end
    end
  end
end
