class Coupon < ApplicationRecord
  belongs_to :promotion
  enum status: { available: 0, burnt: 5, discarded: 10 }

  has_one :burnt_coupon, dependent: :destroy
end
