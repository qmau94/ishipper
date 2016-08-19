class Api::ShopBaseController < Api::BaseController
  before_action :verify_shop

  private
  def verify_shop
    unless current_user.shop?
      render json: {message: I18n.t("shop_ability"), data: {}, code: 0},
        status: 403
    end
  end
end
