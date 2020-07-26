class Scrape
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :url, type: String
  field :site_name, type: String
  embeds_many :images
  embeds_many :links
end
