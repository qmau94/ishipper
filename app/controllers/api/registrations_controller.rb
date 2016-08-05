class Api::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  
  def create
    user = User.new user_params
    if user.save
      render json: {
        message: t("api.sign_up.success"),
        data: {user: user}, code: 1}, 
        status: 201
    else
      warden.custom_failure!
      render json: {message: user.errors.messages, data: {}, code: 0},
        status: 422
    end
  end

  private
  def user_params
    params.require(:user).permit User::ATTRIBUTES_PARAMS
  end
end
