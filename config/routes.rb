Rails.application.routes.draw do
  resources :apex_legends_maps, only: [:index]
end
