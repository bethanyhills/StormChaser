StormChaser::Application.routes.draw do
  devise_for :users
  root "storms#index"
  resources :users
  get '/storms/radiussearch', to: 'storms#search_api_call'
  get '/storms/:id/histweather', to: 'storms#hist_weather_api'
  resources :storms
  get '/search', to: 'storms#search_radius'
end
