module AuthHelper
  def http_login(user)
    @env ||= {}
    u = user.id
    p = user.name
    @env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(u, p)
  end
end
