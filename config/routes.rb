Rails.application.routes.draw do
  get 'scrapes/index'
  get 'scrapes/edit'
  get 'scrapes/show'
  get 'scrapes/update'
  get 'scrapes/delete'
  resources :scrapes
  mount Resque::Server, at: "/jobs"

  # Web
  get "/webber", to: "application#index"


  # Api
  get "/scrape", to: "api/scrape#get"
end
