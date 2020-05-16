module Service
  class Scraper < Base
    attr_accessor :markup, :document, :extractions

    EXTRACTORS = {
        links: Extractors::Links,
        images: Extractors::Images
    }

    def initialize(site_url:, extractors:)
      super(site_url: site_url, extractors: extractors)

      @markup = ""
      @document = nil
      @extractions = {}
    end

    def exec
      fetch
      parse
      extract

      flush(data: extractions)
    end

  private

    def fetch
      # @todo: Potentially handle redirects/moved-permanently responses
      response = Faraday.get site_url

      @markup = response.body if response.status == 200
    end

    def parse
      @document = Nokogiri::HTML.parse(markup)
    end

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