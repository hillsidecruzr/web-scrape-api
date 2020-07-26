class Image
  include Mongoid::Document
  include Mongoid::Timestamps

  field :url, type: String
  field :filetype, type: String
  embeds_one :size
  embedded_in :scrape
end
