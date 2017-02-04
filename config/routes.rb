Rails.application.routes.draw do
  
  root to: "pages#index"
  devise_for :users
  resources :movies
  get 'rents', to: 'movies#rents'
  get 'rent_a_movie/:id', to: 'movies#make_a_rent'
  get 'my_rents', to: 'rents#show_my_rents'
end
