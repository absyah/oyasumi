module HttpAuthConcern
  extend ActiveSupport::Concern

  included do
    before_action :http_authenticate!
  end

  def http_authenticate!
    authenticate_or_request_with_http_basic do |id, name|
      resource = User.find_by(id: id)
      if resource && resource.name == name
        @current_user = resource
      else
        render status: :unauthorized, json: unauthorized_error
      end
    end
  end

  private

  def unauthorized_error
    {
      errors: [
        status: :unauthorized,
          title: 'Not Authorized',
          detail: 'You\'re not authorized to access this resource.'
      ]
    }
  end
end
