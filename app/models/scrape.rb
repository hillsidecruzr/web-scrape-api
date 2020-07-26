class Scrape
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :url, type: String
  field :site_name, type: String
  field :images, type: Array
  field :links, type: Array
end
