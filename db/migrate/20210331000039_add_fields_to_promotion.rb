class AddFieldsToPromotion < ActiveRecord::Migration[5.2]
  def change
    add_column :promotions, :product_id, :integer
    add_column :promotions, :product_key, :string
  end
end
