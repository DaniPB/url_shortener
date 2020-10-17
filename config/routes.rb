Rails.application.routes.draw do
  post '/links', to: 'links#create'
  get 'l/:shortcut', to: 'links#show'
  get '/stats', to: 'links#index'
end
