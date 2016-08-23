class Api::V1::Shop::InvoicesController < Api::ShopBaseController
  before_action :ensure_params_true, only: :index
  before_action :find_object, only: :update

  def index
    invoices = if params[:status] == "all"
      current_user.invoices
    else
      current_user.invoices.send params[:status]
    end
    render json: {message: I18n.t("invoices.messages.get_invoices_success"),
      data: {invoices: invoices}, code: 1}, status: 200
  end

  def update
    @user_invoice = @invoice.user_invoices.find_by_user_id current_user.id
    if check_update_status? && InvoiceStatus.new(@invoice, @user_invoice,
      params[:status]).update_status
      render json: {message: I18n.t("invoices.messages.update_success"),
        data: {invoice: @invoice}, code: 1}, status: 200
    else
      render json: {message: I18n.t("invoices.messages.invoice_error_status"),
        data: {}, code: 0}, status: 200
    end
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

  def check_update_status?
    if params[:status] == "cancel" && !@invoice.finished?
      true
    elsif Invoice.statuses[params[:status]].pred == Invoice.statuses[@invoice.status]
      true
    else
      false
    end
  end
end
