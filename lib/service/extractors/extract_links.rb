module Service
  module Extractors
    module ExtractLinks
      include Interactor

      def call

      end

      def extract(document:, context:, replace: false)
        return unless document.present?

        query = replace ? "#{context}" : "#{context}//a"
        document.xpath(query).map { |tag| { href: tag[:href], text: tag[:text] } }
      end
    end
  end
end