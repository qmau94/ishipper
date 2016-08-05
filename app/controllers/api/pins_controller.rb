class Api::PinsController < Api::BaseController
  before_action :load_user_authentication
  skip_before_action :authenticate_user_from_token

  def new
    unless @user.block_temporary? or @user.blocked?
      @user.send_pin
      render json:
      {message: I18n.t("api.send_pin_success"), data: {}, code: 1},
      status: 200
    end
  end

  def update
    if @user.check_pin(user_params[:pin]) && @user.actived?
      render json:
        {message: t("api.pin_valid"), data: {user: @user}, code: 1},
        status: 200
    else
      render json:
        {message: t("api.pin_invalid"), data: {}, code: 0},
        status: 204
    end
  end

  private
  def user_params
    params.require(:user).permit :phone_number, :password,
      :password_confirmation, :pin
  end

  def load_user_authentication
    @user = User.find_for_database_authentication phone_number: user_params[:phone_number]
    return phone_number_invalid unless @user
  end

  def phone_number_invalid
    render json:
      {message: t("api.phone_number_invalid"), data: {}, code: 0},
      status: 401
  end

  def ensure_params_exist
    return unless params[:user].blank?
    render json:
      {message: t("api.missing_params"), data: {}, code: 0},
      status: 422
  end
end
