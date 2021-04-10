module Api
  class ScrapeController < ApplicationController
    def get
      # @todo: Actually do this in the background
      WebScrapeJob.perform_now(url: site_url_param)

      # @todo: Provide up-to-date execution status
      render json: {status: :executing}
    end

    private

    def site_url_param
      params[:url]
    end
  end
end
