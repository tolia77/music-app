Rails.application.routes.draw do
  resources :albums
  resources :songs
  resources :artists do
    resources :albums, only: [:index]
    resources :songs, only: [:index]
  end
  get 'users/:id', to: 'users#show', as: :user
  get 'users/', to: 'users#index'
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }
end
