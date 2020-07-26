require "json"

module Service
  class Base
    DATA_DIR = Rails.root.join("storage/data").freeze
    FORMATS = [:json, :database]
    EXTRACTORS = {}

    attr_reader :url, :extractors, :extractions

    def initialize(url:, extractors:)
      @url = url
      @extractors = extractors
      @extractions = {}
    end

    def flush(format: :json, data:)
      return unless FORMATS.include? format

      case format
      when :json
        flush_json(data: data)
      when :database
        flush_database(data: data)
      end
    end

    def filename_by_url
      parts = URI.parse(url)

      parts.host.gsub(".", "")
    end

  private

    def extract
      extractors.each do |extractor_name, opts|
        next unless valid_extractor?(extractor: extractor_name)

        opts ||= {}

        extractions[extractor_name] = EXTRACTORS[extractor_name].extract(document: document, **opts)
      end
    end

    def valid_extractor?(extractor:)
      EXTRACTORS.include? extractor
    end

    def flush_json(data:)
      File.open("#{DATA_DIR}/#{filename_by_url}.json", "w") do |f|
        f.puts data.to_json
      end
    end

    def flush_database(data:)
      Scrape.create({
        name: url,
        url: url,
        site_name: "",
        images: extractions[:images],
        links: extractions[:links]
      })
    end
  end
end