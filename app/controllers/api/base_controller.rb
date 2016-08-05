class Api::BaseController < ActionController::API
  include Authenticable
  acts_as_token_authentication_handler_for User, {fallback: :none}
  # skip_before_action :verify_authenticity_token

  respond_to :json

  private
  def authenticate_user_from_token
    authenticate_with_token!
  end
end
