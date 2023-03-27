class CreatePurchaseHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :purchase_histories do |t|
      t.string :pharmacyName
      t.string :maskName
      t.float :transactionAmount
      t.string :transactionDate
      t.references :user, null: false, foreign_key: true
      t.references :mask, null: false, foreign_key: true
      t.references :pharmacy, null: false, foreign_key: true

      t.timestamps
    end
  end
end
