module Api
  class ScrapeController < ApplicationController
    def get
      # @todo: Actually do this in the background
      scrape = WebScrapeJob.perform_now(url: site_url_param)

      # @todo: Provide up-to-date execution status
      render json: scrape, include: [:links, :images]
    end

    private

    def site_url_param
      params[:url]
    end
  end
end
