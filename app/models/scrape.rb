class Scrape
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :url, type: String
  field :site_name, type: String
  has_many :images
  has_many :links
  has_many :containers
end
