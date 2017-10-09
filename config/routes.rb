Rails.application.routes.draw do
  get "stories",  to: "pages#stories"
  resources :charges
  root to: "pages#home"
end
