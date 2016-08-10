class Api::PasswordsController < Devise::PasswordsController
  include Authenticable
  include Confirm

  before_action :authenticate_with_token!, only: :update
  before_action :ensure_params_exist
  before_action :load_user_authentication

  def new
    if @user.actived?
      if @user.check_pin user_params[:pin]
        render json:
          {message: t("api.pin_valid"), data: {user: @user}, code: 1},
          status: 200
      else
        render json:
          {message: t("api.pin_invalid"), data: {}, code: 0},
          status: 200
      end
    else
      render json:
        {message: t("api.sign_in.not_actived"), data: {}, code: 0}, status: 200
    end
  end

  def create
    if @user.actived?
      if @user.reset_password user_params
        render json:
          {message: t("api.update.success"), data: {user: @user}, code: 1},
          status: 200
      else
        render json:
          {message: error_messages(@user.errors.messages), data: {}, code: 0},
          status: 200
      end
    else
      return render json:
        {message: t("api.sign_in.not_actived"), data: {}, code: 0}, status: 200
    end
  end

  def update
    if @user.actived?
      if @user.update_with_password user_params
        render json:
          {message: t("api.update.success"), data: {user: @user}, code: 1},
          status: 200
      else
        render json:
          {message: error_messages(@user.errors.messages), data: {}, code: 0},
          status: 200
      end
    else
      return render json:
        {message: t("api.sign_in.not_actived"), data: {}, code: 0}, status: 200
    end
  end

  private
  def user_params
    params.require(:user).permit :phone_number, :password,
      :password_confirmation, :current_password, :pin
  end
end
