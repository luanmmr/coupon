class Promotion < ApplicationRecord
  has_many :coupons, dependent: :destroy
  enum status: { waiting_for_approval: 0, approved: 1, issued: 2 }

  def generate_coupons
    max_usage.times do |n|
      code = prefix + (n + 1).to_s.rjust(4, '0')
      coupons.create!(code: code)
    end
  end
end
