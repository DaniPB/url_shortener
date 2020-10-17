require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  post '/links', to: 'links#create'
  get 'l/:shortcut', to: 'links#show'
  get '/stats', to: 'links#index'
end
