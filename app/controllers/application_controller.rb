class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  before_action :authorize_request
  attr_reader :current_administrator

private
  def authorize_request
    @current_administrator = (AuthorizeApiRequest.new(request.headers).call)[:administrator]
  end
end
