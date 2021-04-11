class WebScrapeJob < ApplicationJob
  queue_as :default

  def perform(url:)
    # Service::Scraper.new(url: url, extractors: {
    #   links: {
    #     context: "//a[contains(@class, 'grid-product__image-link')]",
    #     replace: true
    #   },
    #   images: {
    #     context: "//div[@class='product--wrapper']"
    #   }
    # }).exec

    # Service::Scraper.new(url: url, extractors: {
    #     links: {
    #         context: "//a[@data-tn-element='jobTitle']",
    #         replace: true
    #     }
    # }).exec

    # @todo: This looks convoluted. Maybe extract the options building so that it isn't so free-form
    # @todo: How-to handle SPA (or do we handle SPA?) The home-depot website has js that loads some values that we don't
    #        get with our HTTP request (aka the price details).
    Service::Scraper.new(url: url, extractors: {
        containers: {
            context: "//div[@class='product-pod--padding']",
            # Each one of these represents an "element" of the container i.e. title, price, description, etc.
            # @note these should not use the '//' but instead '/' since they will be searched within the context
            elements: [".//div[contains(@class, 'product-pod__title')]", ".//div[contains(@class, 'price-format__main-price')]"],
            options: {
                ".//div[contains(@class, 'price-format__main-price')]": {
                    child: "span",
                    strategy: :join
                }
            }
        }
    }).exec
  end
end
