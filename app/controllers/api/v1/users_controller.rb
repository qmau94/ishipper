class Api::V1::UsersController < Api::BaseController
  before_action :ensure_params_exist
  before_action :find_user, only: :update
  before_action :correct_user, only: :update

  def index
    users = if current_user.shop?
      User.shipper
    elsif current_user.shipper?
      User.shop
    end

    render json: {message: "", data: {users: users}, code: 1}, status: 200
  end

  def update
    if @user.update_attributes user_params
      render json: {message: I18n.t("users.messages.update_success"),
        data: {user: @user}, code: 1}, status: 200
    else
      render json: {message: I18n.t("users.messages.update_fails"),
        data: {errors: @user.errors}, code: 0}, status: 200
    end
  end

  private
  def user_params
    params.require(:user).permit User::ATTRIBUTES_PARAMS
  end

  def find_user
    @user = User.find_by id: params[:id]

    render json: {message: I18n.t("users.messages.user_not_found"),
      data: {}, code: 0}, status: 422 unless @user
  end
end
