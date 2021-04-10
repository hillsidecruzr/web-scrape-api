module Service
  module Extractors
    module Links
      class << self
        def extract(url:, document:, context:, replace: false)
          return unless document.present?

          query = replace ? "#{context}" : "#{context}//a"

          links = []
          document.xpath(query).each do |tag|
            uri = URI.parse tag[:href]

            links << Link.create({
               url: uri.absolute? ? tag[:href] : fully_qualified_url(url, tag[:href]),
               external: uri.absolute?, # @todo: how do we pass in context of the scrape as a whole?
               occurrences: 1, # @todo: refactor to query the collection to find others
             })
          end

          links
        end

        def fully_qualified_url(url, relative_url)
          uri = URI.parse url
          return unless [uri.scheme, uri.hostname].filter {|value| !value.nil? && !value.empty? }.any?

          # @todo: May need to do checking to make sure `relative_url` isn't prefixed with a "/"
          "#{uri.scheme}://#{uri.hostname}#{relative_url}"
        end
      end
    end
  end
end