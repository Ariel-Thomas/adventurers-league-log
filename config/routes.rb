AdventurersLeagueLog::Application.routes.draw do
  devise_for :users

  resources :users do
    resources :player_dms

    resources :characters do
      resources :character_log_entries
      resources :trade_log_entries
      resources :character_campaigns, only: [:destroy]
      resources :campaign_log_entries, only: [:show]

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

      resources :campaign_log_entries
    end
    resources :character_campaigns, only: [:create]
  end

  get 'stats', controller: 'home'
  # get 'adventures', controller: 'home'
  resources :adventures, only: [:index] do
    collection do
      get :autocomplete_adventure_name
    end
  end

  get 'donate', controller: 'home'
  root to: 'home#index'
end
