StormChaser::Application.routes.draw do
  devise_for :users
  root "cyclones#index"
  resources :users
  get '/cyclones/radiussearch', to: 'cyclones#search_api_call'
  get '/cyclones/:id/histweather', to: 'cyclones#hist_weather_api'
  resources :cyclones
  get '/search', to: 'cyclones#search_radius'
end
