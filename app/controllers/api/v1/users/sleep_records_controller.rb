module Api
  module V1
    module Users
      class SleepRecordsController < Api::BaseController
        def index
          render json: SleepRecordSerializer.new(current_user.followees_sleep_records)
        end
      end
    end
  end
end
