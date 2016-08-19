class UserInvoice < ApplicationRecord
  has_many :user_invoice_histories, dependent: :destroy

  enum status: [:init, :waitting, :shipping, :shipped, :finished, :cancel]

  belongs_to :user
  belongs_to :invoice

  enum status: [:init, :waiting, :shipping, :shipped, :finished, :cancel]
end
