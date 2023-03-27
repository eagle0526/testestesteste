class MaskPharmacy < ApplicationRecord
  belongs_to :mask
  belongs_to :pharmacy


  scope :by_pharmacy, ->(pharmacy_id) { where(pharmacy_id: pharmacy_id).order(price: :asc) }
  
  scope :by_pharmacy_name, ->(pharmacy_name) { joins(:pharmacy).where(pharmacies: { name: pharmacy_name }).order(price: :asc) }




end
