module Service
  module Extractors
    module Links
      class << self
        def extract(document:, context:, replace: false)
          return unless document.present?

          query = replace ? "#{context}" : "#{context}//a"
          document.xpath(query).map { |tag| linkify tag }
        end

        def linkify(tag)
          uri = URI.parse tag[:href]

          Link.new({
            url: uri.absolute? ? tag[:href] : fully_qualified_url tag[:href],
            external: uri.absolute?,
            occurrences: 1, # @todo: refactor to query the collection to find others
          })

          # conditionally add multimedia
        end

        def fully_qualified_url(relative_url)
          result = document.xpath("//link[@rel='canonical']")

          uri = URI.parse result.first[:href]

          "#{uri.scheme}://#{uri.hostname}/#{relative_url}"
        end
      end
    end
  end
end