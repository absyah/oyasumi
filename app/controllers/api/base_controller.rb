module Api
  class BaseController < ApplicationController
    include ActionController::Helpers
    include ActionController::HttpAuthentication::Basic::ControllerMethods
    include HttpAuthConcern

    helper_method :current_user

    private

    attr_reader :current_user
  end
end
