class Image
  include Mongoid::Document
  include Mongoid::Timestamps

  field :url, type: String
  field :filetype, type: String
  embeds_one :size
  belongs_to :scrape
end
