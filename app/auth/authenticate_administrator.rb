class AuthenticateAdministrator
  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    JsonWebToken.encode(administrator_id: administrator.id) if administrator
  end

private
  attr_reader :email, :password

  def administrator
    administrator = Administrator.find_by(email: email)
    return administrator if administrator && administrator.authenticate(password)
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end
