module Api
  module V1
    module Users
      class SleepRecordsController < Api::BaseController
        # curl GET http://localhost:3000/api/v1/users/sleep_records -u "id:name"
        def index
          render json: SleepRecordSerializer.new(current_user.followees_sleep_records)
        end
      end
    end
  end
end
