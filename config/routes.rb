Rails.application.routes.draw do
  resources :categories
  resources :expences
  resources :incomes do
  	get 'reports', on: :collection
  end 
  devise_for :users

  root "incomes#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
