AdventurersLeagueLog::Application.routes.draw do
  devise_for :users

  resources :users do
    resources :characters do
      resources :log_entries

      member do
        get 'print'
      end
    end
  end

  root to: 'home#index'
end
