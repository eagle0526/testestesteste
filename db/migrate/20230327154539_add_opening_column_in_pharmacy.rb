class AddOpeningColumnInPharmacy < ActiveRecord::Migration[6.1]
  def change
    add_column :pharmacies, :opening_hours, :string
  end
end
