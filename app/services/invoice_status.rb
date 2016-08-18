class InvoiceStatus
  def initialize invoice, user_invoice, status
    @invoice = invoice
    @user_invoice = user_invoice
    @status = status
  end

  def update_status
    @invoice.update_attributes status: @status
    if @invoice.cancel?
      @user_invoice.destroy
    else
      @user_invoice.update_attributes status: @status
    end
    rescue => e
    return false
  end
end
