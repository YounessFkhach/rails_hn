require 'net/http'

class AuthenticateUser
  def initialize(token)
    @token = token
  end

  # Service entry point
  def call
    token = JsonWebToken.encode(user_id: user.id) if user
    return { "auth_token" => token, "user" => user}
  end

  private

  # verify user credentials
  def user
    data = facebook_data
    user = User.find_by(facebook_id: data["id"])
    if user
      return user
    else
      user = User.create({ "name" => data["name"], "facebook_id" => data["id"]})
      return user
    end
  end

  def facebook_data
    url = URI.parse("https://graph.facebook.com/v2.12/me/?access_token=#{@token}")
    res = JSON.parse Net::HTTP.get(url)
    if res["error"]
      raise(ExceptionHandler::AuthenticationError, Message.invalid_token)
    else
      return res if res
    end
  end
end