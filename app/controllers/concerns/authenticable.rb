module Authenticable
  def current_user
    @current_user ||= User.find_by authentication_token: request.headers["Authorization"]
  end

  def authenticate_with_token!
    render json: {message: I18n.t("api.not_authenticated"), data: {},
      code: 0}, status: 401 unless current_user.present?
  end

  def user_signed_in?
    current_user.present?
  end

  def correct_user
    render json: {message: I18n.t("messages.wrong_permission"),
      data: {}, code: 0}, status: 422 unless current_user.current_user? @user
  end
end
