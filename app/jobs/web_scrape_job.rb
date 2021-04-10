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

    # @todo: Trying to figure out how to combing three elements on a page into one to store it
    Service::Scraper.new(url: url, extractors: {
        container: {
            context: "//div[@class='product-pod--padding']",
            # Each one of these represents an "element" of the container i.e. title, price, description, etc.
            elements: ["//div[contains(@class, 'product-pod__title')]", ""]
        }
    }).exec
  end
end
