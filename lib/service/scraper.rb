module Service
  class Scraper < Base
    attr_accessor :markup, :document, :extractions

    EXTRACTORS = {
        links: Extractors::Links
    }

    def initialize(site_url:, extractors:)
      super(site_url: site_url, extractors: extractors)

      @markup = ""
      @document = nil
      @extractions = []
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
      extractors.each do |e|
        next unless EXTRACTORS.include? e

        @extractions << EXTRACTORS[e].extract(document: document)
      end
    end
  end
end