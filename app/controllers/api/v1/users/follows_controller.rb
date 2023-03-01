module Api
  module V1
    module Users
      class FollowsController < Api::BaseController
        before_action :find_user

        # curl -H "Content-Type: application/json" -X POST http://localhost:3000/api/v1/users/:id/follow
        def follow
          current_user.follow!(@user)

          render json: UserSerializer.new(@user)
        end

        # curl -H "Content-Type: application/json" -X POST http://localhost:3000/api/v1/users/:id/unfollow
        def unfollow
          current_user.unfollow!(@user)

          render json: UserSerializer.new(@user)
        end

        private

        def find_user
          @user = User.find_by(id: user_params[:id])
        end

        def user_params
          params.permit(:id)
        end
      end
    end
  end
end
