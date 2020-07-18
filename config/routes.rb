Rails.application.routes.draw do
  mount Resque::Server, at: "/jobs"

  # Web
  get "/webber", to: "application#index"


  # Api
  get "/scrape", to: "api/scrape#get"
end
