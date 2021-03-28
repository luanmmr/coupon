class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.string :code
      t.references :promotion, null: false, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
