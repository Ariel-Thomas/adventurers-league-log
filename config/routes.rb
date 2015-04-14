AdventurersLeagueLog::Application.routes.draw do
  devise_for :users

  resources :users do
    resources :characters do
      resources :log_entries
    end
  end

  root to: 'home#index'
end
