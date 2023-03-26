class CreateMaskPharmacies < ActiveRecord::Migration[6.1]
  def change
    create_table :mask_pharmacies do |t|
      t.float :price
      t.references :mask, null: false, foreign_key: true
      t.references :pharmacy, null: false, foreign_key: true

      t.timestamps
    end
  end
end
