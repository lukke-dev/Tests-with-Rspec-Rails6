Rails.application.routes.draw do
  resources :users, only: %i[index create]
  resources :weapons
end
