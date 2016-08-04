class Api::BaseController < ActionController::API
  acts_as_token_authentication_handler_for User, {fallback: :none}

  respond_to :json
  skip_before_action :verify_authenticity_token

  private
  def authenticate_user_from_token
    entity = SimpleTokenAuthentication::Entity.new User

    if authenticate_entity_from_token!(entity).nil?
      render json: {message: I18n.t("api.invalid_token"), data: {}, code: 0}, status: 401
    end
  end
end
