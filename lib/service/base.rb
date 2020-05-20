require "json"

module Service
  class Base
    DATA_DIR = Rails.root.join("storage/data").freeze
    FORMATS = [:json]
    EXTRACTORS = {}

    attr_reader :url, :extractors

    def initialize(url:, extractors:)
      @url = url
      @extractors = extractors
    end

    def flush(format: :json, data:)
      return unless FORMATS.include? format

      flush_json(data: data) if format == :json
    end

    def filename_by_url
      parts = URI.parse(url)

      parts.host.gsub(".", "")
    end

  private

    def flush_json(data:)
      File.open("#{DATA_DIR}/#{filename_by_url}.json", "w") do |f|
        f.puts data.to_json
      end
    end
  end
end