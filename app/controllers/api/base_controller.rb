class Api::BaseController < ActionController::API
  include Authenticable
  acts_as_token_authentication_handler_for User, {fallback: :none}
  # skip_before_action :verify_authenticity_token

  respond_to :json

  private
  def authenticate_user_from_token
    authenticate_with_token!
  end

  def ensure_params_exist
    missing_params = if params[:controller].present?
      name_controller = params[:controller].split('/').last.singularize
      true if params["#{name_controller}"].blank?
    else
      true
    end
    render json: {message: I18n.t("api.missing_params"), data: {}, code: 0},
      status: 422 if missing_params
  end
end
