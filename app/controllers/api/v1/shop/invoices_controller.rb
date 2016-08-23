class Api::V1::Shop::InvoicesController < Api::ShopBaseController
  before_action :ensure_params_true, only: :index
  before_action :find_object, only: [:update, :destroy, :show]

  def index
    invoices = if params[:status] == "all"
      current_user.invoices
    else
      current_user.invoices.send params[:status]
    end
    render json: {message: I18n.t("invoices.messages.get_invoices_success"),
      data: {invoices: invoices}, code: 1}, status: 200
  end

  def show
    render json: {message: I18n.t("invoices.show.success"),
      data: {invoice: @invoice}, code: 1}, status: 200
  end

  def create
    invoice = current_user.invoices.build invoice_params
    if invoice.save
      render json: {message: I18n.t("invoices.create.success"),
        data: {invoice: invoice}, code: 1}, status: 201 
    else
      render json: {message: I18n.t("invoices.create.fail"), data: {},
        code: 0}, status: 200
    end
  end

  def update
    if params[:status]
      @user_invoice = @invoice.user_invoices.find_by_user_id current_user.id
      if check_update_status? && InvoiceStatus.new(@invoice, @user_invoice,
        params[:status]).update_status
        render json: {message: I18n.t("invoices.messages.update_success"),
          data: {invoice: @invoice}, code: 1}, status: 200
      else
        render json: {message: I18n.t("invoices.messages.invoice_error_status"),
          data: {}, code: 0}, status: 200
      end
    else
      if InvoiceHistoryCreator.new(@invoice).create_history(invoice_params)
        render json: {message: I18n.t("invoices.update.success"),
          data:{invoice: @invoice}, code: 1}, status: 200
      else
        render json: {message: error_messages(@invoice.errors.messages), data: {},
          code: 0}, status: 200
      end
    end
    
  end

  def destroy
    if current_user == @invoice.user && @invoice.destroy
      render json: {message: I18n.t("invoices.delete.success"), data: {},
        code:1}, status: 200
    else
      render json: {message: I18n.t("invoices.delete.fails"), data: {},
        code:0},status: 200
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

  def invoice_params
    params.require(:invoice).permit Invoice::ATTRIBUTES_PARAMS
  end
end
