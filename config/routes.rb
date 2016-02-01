AdventurersLeagueLog::Application.routes.draw do
  devise_for :users

  resources :users do
    resources :characters do
      resources :character_log_entries

      member do
        get 'print'
        get 'print_condensed'
      end
    end

    resources :dm_log_entries
  end

  get 'stats', controller: 'home'
  get 'adventures', controller: 'home'
  root to: 'home#index'
end
