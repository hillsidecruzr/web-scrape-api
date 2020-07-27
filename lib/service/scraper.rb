module Service
  class Scraper < Base
    include ::Service::Concerns::Fetchable
    include ::Service::Concerns::Parsable

    attr_accessor :document, :persistance

    def initialize(url:, extractors:, persistance: :database)
      super(url: url, extractors: extractors)

      @markup = ""
      @document = nil
    end

    def exec
      @document = (fetchable >> parsable).call url
      extract

      flush(format: persistance, data: extractions)
    end
  end
end