Rails.application.routes.draw do
  resources :contents, path: '/api/contents'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
