Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :masks
  resources :mask_pharmacies do
    collection do
      get :mask_count
      get :opening
    end
  end

end
