module Service
  module Extractors
    module Links
      class << self
        def extract(document:)
          return unless document.present?

          document.xpath("//a").map { |tag| { href: tag[:href], text: tag[:text] } }
        end
      end
    end
  end
end