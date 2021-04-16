class PromotionsController < ApplicationController
  before_action :all_promotions, only: :index
  before_action :all_products, only: %i[index create edit update]

  def index
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new(promotion_params)
    fill_promotion_fields
    return redirect_to promotions_path, notice: t('.success') \
           if @promotion.save
    
    flash.now[:alert] = t('.error')
    render :index
  end
  
  def edit
    @promotion = Promotion.find(find_promotion.fetch(:id))
  end

  def update
    @promotion = Promotion.find(find_promotion.fetch(:id))
    return redirect_to promotions_path, notice: t('.success') \
           if @promotion.update(promotion_params)
    
    flash.now[:alert] = t('.error')
    render :edit
  end

  def show
    @promotion = Promotion.find(find_promotion.fetch(:id))
    @cupons = @promotion.coupons.where(status: :available)
  end

  def approve
    promotion = Promotion.find(find_promotion.fetch(:id))
    promotion.approved!
    redirect_back fallback_location: promotion_path, 
                  notice: t('.approved')
  end

  def generate_coupons
    @promotion = Promotion.find(find_promotion.fetch(:id))
    if @promotion.approved?
      @promotion.issued!
      @promotion.generate_coupons
      redirect_back fallback_location: promotion_path,
                    notice: @promotion.max_usage.to_s + " " +
                            t('.created_cupons')
    else
      redirect_back fallback_location: promotion_path,
                    alert: t('.not_approved')
    end
  end


  private

  def all_promotions
    @promotions = Promotion.all
  end

  def promotion_params
    params.require(:promotion).permit(:description, :prefix,
      :discount_percentage, :max_discount_value, :start_date,
      :end_date, :max_usage, :product_id)
  end

  def find_promotion
    params.permit(:id)
  end

  def all_products
    @products = Product::Client.all
  end

  def fill_promotion_fields
    @promotion.user = current_user
    product = Product::Client.find(@promotion.product_id.to_i)
    @promotion.product_key = product.key
  end
end