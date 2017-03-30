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
        get 'export'

        get 'print'
        get 'print_condensed'
      end
    end

    resources :dm_log_entries do
      collection do
        get 'print'
      end
    end


    resources :campaigns  do
      collection do
        get  'join_as_dm'
        get  'join_as_character'
      end

      resources :campaign_log_entries
    end
    resources :dm_campaign_assignments, only: [:create, :destroy]
    resources :character_campaigns, only: [:create, :destroy]
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
