Rails.application.routes.draw do
  # Web
  get "/webber", to: "application#index"


  # Api
  get "/scrape", to: "api/scrape#get"
end
