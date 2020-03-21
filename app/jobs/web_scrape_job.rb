class WebScrapeJob < ApplicationJob
  queue_as :default

  def perform(url:)
    Service::Scraper.new(site_url: url, extractors: [:links]).exec
  end
end
