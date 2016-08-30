AdventurersLeagueLog::Application.routes.draw do
  devise_for :users

  resources :users do
    resources :characters do
      resources :character_log_entries
      resources :trade_log_entries
      resources :character_campaigns, only: [:destroy]

      member do
        get 'print'
        get 'print_condensed'
      end
    end

    resources :dm_log_entries

    resources :campaigns  do
      collection do
        get  'join'
      end
    end
    resources :character_campaigns, only: [:create]
  end

  get 'stats', controller: 'home'
  get 'adventures', controller: 'home'

  get 'donate', controller: 'home'
  root to: 'home#index'
end
