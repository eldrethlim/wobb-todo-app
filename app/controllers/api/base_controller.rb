class API::BaseController < ActionController::Base

  rescue_from NotAuthenticatedError do
    render json: { error: 'Not Authorized'}, status: 401
  end

  private

  def authenticate_request
    fail NotAuthenticatedError if !current_api_user
  end

  def current_api_user
    decoded_auth_token ||= AuthToken.decode(http_auth_header_content)
    @current_api_user ||= User.find(decoded_auth_token["user_id"]) if decoded_auth_token
  end

  def http_auth_header_content
    return @http_auth_header_content if defined?(@http_auth_header_content)

    @http_auth_header_content = begin
      return request.headers['Authorization'] if request.headers['Authorization'].present?
      nil
    end
  end
end
