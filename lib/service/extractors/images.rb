module Service
  module Extractors
    module Images
      class << self
        def extract(url:, document:, context:)
          return unless document.present?

          document.xpath("#{context}//img").map do |tag|
            {
              src: tag[:src] || "",
              alt: tag[:alt] || "",
              srcset: tag[:srcset] || "",
              dataSrc: tag["data-src"] || "",
              dataWidths: tag["data-widths"] || ""
            }
          end
        end
      end
    end
  end
end