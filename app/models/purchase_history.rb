class PurchaseHistory < ApplicationRecord
  belongs_to :user
  belongs_to :mask
  belongs_to :pharmacy
end
