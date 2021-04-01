class Promotion < ApplicationRecord
  belongs_to :user
  has_many :coupons, dependent: :destroy
  enum status: { waiting_for_approval: 0, approved: 1, issued: 2 }
  validates :description, :prefix, :discount_percentage,
            :max_discount_value, :start_date, :end_date,
            :max_usage, presence: true
  validates :prefix, length: { maximum: 6 }
  validates :discount_percentage, :max_discount_value, 
             numericality: { greater_than: 0, 
                             less_than_or_equal_to: 100 }

  validate :start_date_in_present_or_future?
  validate :end_date_greater_than_start_date?

  def generate_coupons
    max_usage.times do |n|
      code = prefix + (n + 1).to_s.rjust(4, '0')
      coupons.create!(code: code)
    end
  end

  private

  def start_date_in_present_or_future?
    return true if start_date.present? && start_date >= Date.today
    add_custom_error(attribute: :start_date, 
                     message: I18n.t(:start_date_in_past, scope: :validate))
    false
  end

  def end_date_greater_than_start_date?
    return true if end_date.present? && end_date > start_date
    add_custom_error(attribute: :end_date,
                     message: I18n.t(:end_dt_smaller_than_start_dt, 
                                     scope: :validate))
    false  
  end

  def add_custom_error(attribute:, message:)
    errors.add(attribute, message)
  end
end
