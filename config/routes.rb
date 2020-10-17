Rails.application.routes.draw do
  post '/links', to: 'links#create'
  get '/:shortcut', to: 'links#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
