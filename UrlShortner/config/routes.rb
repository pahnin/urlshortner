Rails.application.routes.draw do
  resources :links
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  devise_scope :user do
    delete "/users/sign_out" => "devise/sessions#destroy"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"

  match "/u/:shortcode", to: 'home#redirect_shortcode', via: :get
end
