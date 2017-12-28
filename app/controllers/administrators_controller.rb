class AdministratorsController < ApplicationController
  skip_before_action :authorize_request, only: :create

  def create
    administrator = Administrator.create!(administrator_params)
    auth_token = AuthenticateAdministrator.new(administrator.email, administrator.password).call
    response = {message: Message.account_created, auth_token: auth_token}
    json_response(response, :created)
  end

private
  def administrator_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
