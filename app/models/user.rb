class User < ApplicationRecord
  acts_as_token_authenticatable

  devise :database_authenticatable, :recoverable,
    :rememberable, :trackable, :validatable

  has_many :invoices, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :notifications, dependent: :destroy

  ATTRIBUTES_PARAMS = [:phone_number, :email, :address, :latitude,
    :longitude, :plate_number, :status, :role, :rate, :pin,
    :password, :password_confirmation]

  enum role: ["admin", "shop", "shipper"]

  def send_pin
    twilio_client = Twilio::REST::Client
      .new Rails.application.secrets.twilio_account_sid,
      Rails.application.secrets.twilio_auth_token
    pin = SecureRandom.urlsafe_base64[0..3]
    self.update_attributes pin: pin
    twilio_client.messages.create to: "#{self.phone_number}",
      from: "#{Settings.from_phone_number}", body: I18n.t("your_pin", pin: pin)
  end

  def current_user? user
    self == user
  end
end
