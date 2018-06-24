Rails.application.routes.draw do
  resources :login, only: [:index]
  post '/login', to: 'members#index'
  get '/teams/members/:name', to: 'members#index'
  post '/teams/members', to: 'members#index'
  get '/members/:id/:kind', to: 'members#edit'
  post '/members/:id/game', to: 'members#update_game'
  post '/members/:id/score', to: 'members#update_score'
end
