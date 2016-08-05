class Api::BaseController < ActionController::API
  # acts_as_token_authentication_handler_for User, {fallback: :none}
  # skip_before_action :verify_authenticity_token
  include Authenticable

  respond_to :json

  # private
  # def authenticate_user_from_token
  #   entity = SimpleTokenAuthentication::Entity.new User

  #   if authenticate_entity_from_token!(entity).nil?
  #     render json: {message: I18n.t("api.invalid_token"), data: {}, code: 0}, status: 401
  #   end
  # end
end
