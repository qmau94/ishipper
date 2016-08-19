class Api::ShipperBaseController < Api::BaseController
  before_action :verify_shipper

  private
  def verify_shipper
    unless current_user.shipper?
      render json: {message: I18n.t("users.messages.not_authorize"), data: {},
        code: 0}, status: 403
    end
  end
end
