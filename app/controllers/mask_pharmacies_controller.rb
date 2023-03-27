class MaskPharmaciesController < ApplicationController
  def index    

    if params[:pharmacy_id]
      @pharmacy = Pharmacy.find(params[:pharmacy_id])
      @mps = MaskPharmacy.by_pharmacy(params[:pharmacy_id])
    elsif params[:pharmacy_name]
      @pharmacy = Pharmacy.find_by(name: params[:pharmacy_name])
      @mps = MaskPharmacy.by_pharmacy_name(params[:pharmacy_name])
    else
      @mps = MaskPharmacy.all
    end
    # if params[:pharmacy_id]
    #   @pharmacy = Pharmacy.find(params[:pharmacy_id])
    #   @mps = MaskPharmacy.by_pharmacy(params[:pharmacy_id])
    # else
    #   @mps = MaskPharmacy.all
    # end

    # if params[:pharmacy_name]
    #   @pharmacy = Pharmacy.find_by(name: params[:pharmacy_name])
    #   @mps = MaskPharmacy.by_pharmacy_name(params[:pharmacy_name])
    # else
    #   @mps = MaskPharmacy.all
    # end


    render json: @mps.map { |mp| mp.attributes.except('created_at', 'updated_at').merge({'mask_name' => mp.mask.name}).merge( {'pharmacy_name' => mp.pharmacy.name} ) }

  end
end


    # render json: @mps.as_json(except: [:created_at, :updated_at]).map { |mp| mp.merge({ mask_name: mp.mask.name }) }

    # render json: @mps
    # render json: @mps.map { |mp| mp.attributes.except('created_at', 'updated_at') }, include: :mask

    # render json: @mps, include: :mask
    
    # format.json { render :show, status: :ok, location: @user }