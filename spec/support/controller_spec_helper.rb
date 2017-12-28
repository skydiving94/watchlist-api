module ControllerSpecHelper
  def token_generator(administrator_id)
    JsonWebToken.encode(administrator_id: administrator_id)
  end

  def expired_token_generator(administrator_id)
    JsonWebToken.encode({administrator_id: administrator_id}, (Time.now.to_i - 10))
  end

  def valid_headers
    {
      "Authorization" => token_generator(administrator.id),
      "Context-Type" => "application/json"
    }
  end

  def invalid_headers
    {
      "Authorization" => nil,
      "Content-Type" => "application/json"
    }
  end
end
