class CreatePharmacies < ActiveRecord::Migration[6.1]
  def change
    create_table :pharmacies do |t|
      t.string :name
      t.float :cashBalance

      t.timestamps
    end
  end
end
