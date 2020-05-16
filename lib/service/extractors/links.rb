module Service
  module Extractors
    module Links
      class << self
        def extract(document:, context:, replace: false)
          return unless document.present?

          query = replace ? "#{context}" : "#{context}//a"
          document.xpath(query).map { |tag| { href: tag[:href], text: tag[:text] } }
        end
      end
    end
  end
end