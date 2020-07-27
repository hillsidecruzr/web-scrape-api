module Service
  module Extractors
    module Links
      class << self
        def extract(document:, context:, replace: false)
          return unless document.present?

          query = replace ? "#{context}" : "#{context}//a"
          document.xpath(query).each do |tag|
            uri = URI.parse tag[:href]

            Link.new({
               url: uri.absolute? ? tag[:href] : fully_qualified_url(document, tag[:href]),
               external: uri.absolute?, # @todo: how do we pass in context of the scrape as a whole?
               occurrences: 1, # @todo: refactor to query the collection to find others
             })
          end
        end

        def fully_qualified_url(document, relative_url)
          result = document.xpath("//link[@rel='canonical']")

          uri = URI.parse result.first[:href]

          # @todo: May need to do checking to make sure `relative_url` isn't prefixed with a "/"
          "#{uri.scheme}://#{uri.hostname}#{relative_url}"
        end
      end
    end
  end
end