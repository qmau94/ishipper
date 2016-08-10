module Confirm
  def ensure_params_exist
    return unless params[:user].blank?
    render json: {message: t("api.missing_params"), data: {}, code: 0}, status: 422
  end

  def error_messages object
    error = ""
    object.each do |messageType, message|
      error << messageType.to_s.classify + t("api.invalid") + "\n"
    end
    error
  end

  def load_user_authentication
    @user = User.find_for_database_authentication phone_number: user_params[:phone_number]
    return phone_number_invalid unless @user
  end

  def phone_number_invalid
    render json:
      {message: t("api.phone_number_invalid"), data: {}, code: 0},
      status: 200
  end
end
