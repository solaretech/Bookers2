Rails.application.routes.draw do
  root 'books#top'
  resources :books
  resources :users, only:[:index, :show, :edit, :update]
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/about' => 'books#about', as: 'about'
end
