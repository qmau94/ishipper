class Api::V1::Shipper::InvoicesController < Api::ShipperBaseController
  before_action :find_object, only: :update

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
