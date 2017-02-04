Rails.application.routes.draw do
  
  root to: "pages#index"
  devise_for :users
  resources :movies
  get 'rents', to: 'movies#rents'
  get 'rent_a_movie', to: 'movies#make_a_rent'
  post 'rent_a_movie', to: 'movies#create_a_rent'
  get 'my_rents', to: 'rents#show_my_rents'
end
