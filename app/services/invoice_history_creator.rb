class InvoiceHistoryCreator
  def initialize invoice
    @invoice = invoice
  end

  def create_history invoice_params
    if @invoice.update_attributes invoice_params
      create_invoice_history
      return true 
    else
      return false
    end
  end

  def create_invoice_history
    InvoiceHistory.create! name: @invoice.name,
    address_start: @invoice.address_start, 
    latitude_start: @invoice.latitude_start,
    longitude_start: @invoice.longitude_start,
    address_finish: @invoice.address_finish,
    latitude_finish: @invoice.latitude_finish,
    longitude_finish: @invoice.longitude_finish,
    delivery_time: @invoice.delivery_time,
    distance: @invoice.distance,
    description: @invoice.distance,
    price: @invoice.price,
    shipping_price: @invoice.shipping_price,
    status: @invoice.status,
    weight: @invoice.weight,
    customer_name: @invoice.customer_name,
    customer_number: @invoice.customer_number,
    invoice_id: @invoice.id
  end

  def create_user_history user_invoice, status
    UserInvoiceHistory.create! status: status,
      user_invoice_id: user_invoice.id
  end

  def create_all_history user_invoice, status
    create_invoice_history
    create_user_history user_invoice, status
  end
end
