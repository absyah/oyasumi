module Api
  class BaseController < ApplicationController
    include ActionController::Helpers

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    before_action :authenticate_user!

    helper_method :current_user

    private

    def authenticate_user!
      # TODO
      # auth mechanism
      @current_user = User.find(1)
    end

    def record_not_found
      # TODO
      # refactor this
      render status: :unauthorized, json: {
        errors: [
          status: :unauthorized,
          title: 'Not Authorized',
          detail: 'You\'re not authorized to access this resource.'
        ]
      }
    end

    attr_reader :current_user
  end
end
