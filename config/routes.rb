BeerOff::Application.routes.draw do

  resources :categories, only: [ :index, :show ]
  resources :breweries, only: [ :index, :show ]
  resources :beers, only: [ :index ]
  resources :styles, only: [ :index ]

  root 'categories#index'

end
