class Mask < ApplicationRecord
  has_many :mask_pharmacies
  has_many :pharmacies, through: :mask_pharmacies
end
