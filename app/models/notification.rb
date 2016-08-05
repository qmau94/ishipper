class Notification < ApplicationRecord
  belongs_to :owner, class_name: User.name
  belongs_to :recipient, class_name: User.name
end
