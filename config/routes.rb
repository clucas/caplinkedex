Rails.application.routes.draw do
  resources :books do
    collection do
      get :autocomplete
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
