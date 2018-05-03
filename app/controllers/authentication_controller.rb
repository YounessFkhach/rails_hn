class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate
  def authenticate
    result = AuthenticateUser.new(auth_params[:facebook_token]).call
    json_response(result)
  end

  private

  def auth_params
    params.permit(:facebook_token)
  end
end
