AdventurersLeagueLog::Application.routes.draw do
  devise_for :users

  resources :users do
    resources :characters do
      resources :character_log_entries

      member do
        get 'print'
      end
    end

    resources :dm_log_entries
  end

  root to: 'home#index'
end
