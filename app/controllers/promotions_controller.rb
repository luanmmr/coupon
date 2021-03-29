class PromotionsController < ApplicationController
  before_action :all_promotions

  def index
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new(promotion_params)
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


  private

  def all_promotions
    @promotions = Promotion.all
  end

  def promotion_params
    params.require(:promotion).permit(:description, :prefix,
      :discount_percentage, :max_discount_value, :start_date,
      :end_date, :max_usage)
  end

  def find_promotion
    params.permit(:id)
  end
end