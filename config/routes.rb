StormChaser::Application.routes.draw do
  devise_for :users
  root "cyclones#landing_page"
  resources :users
  get '/cyclones/radiussearch', to: 'cyclones#search_api_call'
  resources :cyclones
  get '/search', to: 'cyclones#search_radius'
  namespace :api do
    namespace :v1 do
      get 'cyclones/:id/histweather', to: 'cyclones#hist_weather_api'
      resources :cyclones
      get 'search', to: 'searches#index'
      get 'search/:search_name', to: 'searches#search'
      get 'search/:search_name/:selectors', to: 'searches#search'
    end
  end
end
