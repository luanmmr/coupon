class CouponsController < ApplicationController
  def show
    @promotion = Promotion.find(find_params.fetch(:promotion_id))
    @coupon = Coupon.find(find_params.fetch(:id))
  end
  def discard; end

  private

  def find_params
    params.permit(:promotion_id, :id)
  end
end