class Api::SessionsController < Devise::SessionsController
  include Confirm

  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  skip_before_action :verify_signed_out_user

  before_action :ensure_params_exist, only: [:create, :destroy]
  before_action :load_user_authentication

  respond_to :json

  def create
    if @user.valid_password? user_params[:password]
      if @user.actived?
        sign_in @user, store: false
        @user.update_attributes signed_in: true
        render json: {message: t("api.sign_in.success"),
          data: {user: @user}, code: 1}, status: 200
        return
      else
        render json: {message: t("api.sign_in.not_actived"), data: {}, code: 0},
          status: 200
        return
      end
    end
    invalid_login_attempt
  end

  def destroy
    if @user.authentication_token == user_params[:authentication_token]
      sign_out @user
      generate_authentication_token
      render json: {message: t("api.sign_out.success"), data: {}, code: 1}, status: 200
    else
      render json: {message: t("api.invalid_token"), data: {}, code: 0}, status: 200
    end
  end

  private
  def user_params
    params.require(:user).permit :phone_number, :password, :authentication_token
  end

  def invalid_login_attempt
    render json: {message: t("api.sign_in.fails"), data: {}, code: 0}, status: 200
  end

  def generate_authentication_token
    @user.update_attributes authentication_token: Devise.friendly_token
  end
end
