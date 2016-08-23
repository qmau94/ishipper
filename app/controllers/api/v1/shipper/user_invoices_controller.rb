class Api::V1::Shipper::UserInvoicesController < Api::ShipperBaseController
  before_action :ensure_params_exist

  def create
    @user_invoice = current_user.user_invoices.build user_invoice_params
    if @user_invoice.save
      render json: {message: I18n.t("user_invoices.create_success"),
        data: {user_invoice: @user_invoice}, code: 1}, status: 200
    else
      render json: {message: I18n.t("user_invoices.create_fail"), data: {},
        code: 0}, status: 200
    end
  end

  private
  def user_invoice_params
    params.require(:user_invoice).permit :invoice_id
  end
end
