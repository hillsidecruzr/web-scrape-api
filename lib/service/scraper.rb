module Service
  class Scraper < Base
    include ::Service::Concerns::Fetchable
    include ::Service::Concerns::Parsable

    attr_accessor :document, :extractions

    EXTRACTORS = {
        links: Extractors::Links,
        images: Extractors::Images
    }

    def initialize(url:, extractors:)
      super(url: url, extractors: extractors)

      @markup = ""
      @document = nil
      @extractions = {}
    end

    def exec
      @document = (fetchable >> parsable).call url
      extract

      flush(data: extractions)
    end

  private

    def extract
      extractors.each do |extractor_name, opts|
        next unless valid_extractor?(extractor: extractor_name)

        opts ||= {}

        @extractions[extractor_name] = EXTRACTORS[extractor_name].extract(document: document, **opts)
      end
    end

    def valid_extractor?(extractor:)
      EXTRACTORS.include? extractor
    end
  end
end