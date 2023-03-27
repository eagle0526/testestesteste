# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks




desc "create pharmacy json file"
task :create_pharmacies_and_masks => :environment do
p "開始讀取json檔案"
pharmacies_json = JSON.parse(File.read('data/pharmacies.json'))

p "新增pharmacy"


pharmacies_json.each do |pharmacy_data|
  pharmacy = Pharmacy.create(name: pharmacy_data["name"], cashBalance: pharmacy_data["cashBalance"])
  pharmacy_data["masks"].each do |mask_data|
    mask = Mask.find_or_create_by(name: mask_data["name"])
    MaskPharmacy.create(price: mask_data["price"], mask: mask, pharmacy: pharmacy)
  end
end

end
  





desc "create user json file"
task :create_user_and_purchase_histories => :environment do
p "讀取json檔案"  
users_json = JSON.parse(File.read('data/users.json'))

p "新增user"
users_json.each do |user_data|
  user = User.create(name: user_data["name"], cashBalance: user_data["cashBalance"])
    
  user_data["purchaseHistories"].each do |purchase_data|
    mask = Mask.find_or_create_by(name: purchase_data["maskName"])
    pharmacy = Pharmacy.find_or_create_by(name: purchase_data["pharmacyName"])
    mask_pharmacy = MaskPharmacy.find_or_create_by(mask: mask, pharmacy: pharmacy, price: purchase_data["transactionAmount"])
    PurchaseHistory.create(pharmacyName: pharmacy.name, maskName: mask.name, user: user, mask: mask, pharmacy: pharmacy, transactionAmount: purchase_data["transactionAmount"], transactionDate: purchase_data["transactionDate"])
  end
end

end