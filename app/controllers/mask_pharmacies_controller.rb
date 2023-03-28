class MaskPharmaciesController < ApplicationController

  # before_action :relevance_score, only: [:name_relevance]

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

    render json: @mps.map { |mp| mp.attributes.except('created_at', 'updated_at').merge({'mask_name' => mp.mask.name}).merge( {'pharmacy_name' => mp.pharmacy.name} ) }

  end

  def mask_count
    # render html: params
    
    min_price = params[:min_price]
    max_price = params[:max_price]    
    mask_count = params[:mask_count].to_i

    # 所有的藥局
    @pharmacies = Pharmacy.all
    # 給定價格區間，並印出藥局、口罩資料
    @mps = MaskPharmacy.within_price_range(min_price, max_price)

    @result = []
    
    # 先給定一個價格區間後，設定一個變數 -> 價格篩選過後的藥局 id = 所有藥局 id => 所有
    @pharmacies.each do |pharmacy|
      
      mask_pharmacies = @mps.select { |mp| mp.pharmacy_id == pharmacy.id }
      mask_pharmacies_count = mask_pharmacies.count      

      if mask_pharmacies_count >= mask_count
        status = 'more'
      else
        status = 'less'
      end

      @result << { 'pharmacy_name' => pharmacy.name, 'status' => status }
    end

    render json: @result
  end

  # 未完成
  def opening    

    @pharmacies = Pharmacy.all
    time_format = "%a, %b, %d %H:%M"

    def parse_opening_hours(opening_hours_str)
      opening_hours_str = opening_hours_str.gsub(/(\w{3}), /, "") # 刪除逗號和星期幾的縮寫
      times = opening_hours_str.scan(/\d{2}:\d{2}/) # 找出時間字串中的所有時間
      times.map { |time_str| DateTime.strptime(time_str, time_format) } # 將時間字串轉換成時間物件
    end
    
    # render json: @pharmacies

  end

  def name_relevance    
    pharmacy_name = params[:pharmacy]    
    mask_name = params[:mask]    

    if pharmacy_name
      @pharmacies = Pharmacy.where("name LIKE ?", "%#{pharmacy_name}%").sort_by { |pharmacy| -relevance_score(pharmacy, pharmacy_name) }
      json_data = @pharmacies.map do |pharmacy|
        {
          name: pharmacy.name,
          cash_balance: pharmacy.cashBalance,
          opening_hours: pharmacy.opening_hours,
          relevance_score: relevance_score(pharmacy, pharmacy_name)
        }
      end
    else
      @masks = Mask.where("name LIKE ?", "%#{mask_name}%").sort_by { |mask| -relevance_score(mask, mask_name) }      
      json_data = @masks.map do |mask|
        {
          name: mask.name,                    
          relevance_score: relevance_score(mask, mask_name)
        }
      end
    end



    render json: json_data
  end

  private  

  def relevance_score(term, search_term)
    name = term.name.downcase
    search_term = search_term.downcase

    # 計算相關度分數
    score = 0
    score += 10 if name.starts_with?(search_term)
    score += 5 if name.include?(search_term)
    score += 1 if name.end_with?(search_term)
    score
  end

end

