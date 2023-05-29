Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    sessions: "users/sessions"
  }

  get :creators, to: "pages#creators"
  root "pages#index"
end
