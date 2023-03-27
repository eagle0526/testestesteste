class Pharmacy < ApplicationRecord
  has_many :mask_pharmacies
  has_many :masks, through: :mask_pharmacies

  has_many :purchase_histories
end
