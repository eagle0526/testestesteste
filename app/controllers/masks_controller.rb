class MasksController < ApplicationController
  def index
    @masks = Mask.all

    pharmacy_id = params[:pharmacy_id]
    # sort_by = params[:sort_by]
    
    # masks = Mask.where(pharmacy_id: pharmacy_id)
    pharmacies = Pharmacy.where(pharmacy_id: pharmacy_id)

    # if sort_by == 'name'
    #     masks = masks.order(:name)
    #   elsif sort_by == 'price'
    #     masks = masks.order(:price)
    # end


    # render json: pharmacies
    

  end
end