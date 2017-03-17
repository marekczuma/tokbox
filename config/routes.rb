Rails.application.routes.draw do
  root 'users#stream'

  devise_for :users

  get '/watch/:id', to: 'users#watch', as: :watch
  get '/stream', to: 'users#stream', as: :stream
end
