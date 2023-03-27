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

# pharmacies_json.each do |pharmacy_data|    

#   pharmacy = Pharmacy.create(
#     name: pharmacy_data['name'],
#     cashBalance: pharmacy_data['cashBalance'],
#     # openingHours: pharmacy_data['openingHours']
#   )

#   mask = pharmacy_data['masks'].each do |mask|
#     mask = Mask.create(
#       name: mask['name'],
#     #   price: mask['price']      
#     )
#     MaskPharmacy.create(mask: mask, pharmacy: pharmacy)
#   end

# end

end
  
