class User < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :notifications, dependent: :destroy
end
