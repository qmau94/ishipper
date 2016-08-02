class Invoice < ApplicationRecord
  has_many :user_invoices, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :invoice_histories, dependent: :destroy

  belongs_to :user
end
