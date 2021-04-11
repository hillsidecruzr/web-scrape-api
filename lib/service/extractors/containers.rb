module Service
  module Extractors
    module Containers
      class << self
        def extract(url:, document:, context:, elements:, options:)
          return unless document.present?

          containers = []
          document.xpath("#{context}").each do |container|
            scraped_elements = []
            elements.each do |el_selector|
              element = if options[el_selector.to_sym]
                          scrape_element(container, el_selector, options[el_selector.to_sym])
                        else
                          container.xpath(el_selector).text
                        end
              scraped_elements << element
            end

            containers << Container.create({
                path: context,
                elements: scraped_elements
                                           })
          end

          containers
        end

        private

        def scrape_element(container, selector, opts)
          selector = "#{selector}/#{opts[:child]}" if opts[:child]

          if opts[:strategy] == :join
            container.xpath(selector).map(&:text).join
          else
            container.xpath(selector).map(&:text).join
          end
        end
      end
    end
  end
end