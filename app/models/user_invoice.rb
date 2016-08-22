class UserInvoice < ApplicationRecord
  belongs_to :user
  belongs_to :invoice

  enum status: [:init, :waiting, :shipping, :shipped, :finished, :cancel]
end
