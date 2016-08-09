class Api::RegistrationsController < Devise::RegistrationsController
  include Confirm

  before_action :ensure_params_exist

  respond_to :json

  def create
    user = User.new user_params
    if user.save
      if user.send_pin
        render json: {
          message: t("api.sign_up.success"),
          data: {user: user}, code: 1},
          status: 200
      else
        phone_number_invalid
      end
    else
      warden.custom_failure!
      render json: {message: error_messages(user.errors.messages), data: {}, code: 0},
        status: 200
    end
  end

  private
  def user_params
    params.require(:user).permit User::ATTRIBUTES_PARAMS
  end
end
