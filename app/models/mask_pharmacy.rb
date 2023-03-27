class MaskPharmacy < ApplicationRecord
  belongs_to :mask
  belongs_to :pharmacy


  # 第二題
  scope :by_pharmacy, ->(pharmacy_id) { where(pharmacy_id: pharmacy_id).order(price: :asc) }
  
  scope :by_pharmacy_name, ->(pharmacy_name) { joins(:pharmacy).where(pharmacies: { name: pharmacy_name }).order(price: :asc) }

  # 第三題
  scope :within_price_range, ->(min_price, max_price) { where(price: min_price..max_price) }


end
