class Api::V1::Shop::InvoicesController < Api::ShopBaseController
  before_action :ensure_params_true, only: :index

  def index
    invoices = if params[:status] == "all"
      current_user.invoices
    else
      current_user.invoices.send params[:status]
    end
    render json: {message: I18n.t("invoices.messages.get_invoices_success"),
      data: {invoice: invoices}, code: 1}, status: 200
  end

  private
  def ensure_params_true
    statuses = Invoice.statuses
    statuses["all"] = 6
    unless (params[:status].nil? || params[:status].in?(statuses)) && params.has_key?(:status)
      render json: {message: I18n.t("invoices.messages.missing_params"), data: {}, code: 0},
        status: 422
    end
  end
end
