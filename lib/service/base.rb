require "json"

module Service
  class Base
    DATA_DIR = Rails.root.join("lib/data").freeze
    FORMATS = [:json]
    EXTRACTORS = {}

    attr_reader :site_url, :extractors

    def initialize(site_url:, extractors:)
      @site_url = site_url
      @extractors = extractors
    end

    def flush(format: :json, data:)
      return unless FORMATS.include? format

      flush_json(data: data) if format == :json
    end

    def filename_by_url
      parts = URI.parse(site_url)

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