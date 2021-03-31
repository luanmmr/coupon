class AddUserRefToPromotion < ActiveRecord::Migration[5.2]
  def change
    add_reference :promotions, :user, foreign_key: true
  end
end
