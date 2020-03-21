Rails.application.routes.draw do
  get "/scrape", to: "scrape#get"
end
