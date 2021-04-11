class Container
  include Mongoid::Document
  include Mongoid::Timestamps

  field :path, type: String
  field :elements, type: Array

  belongs_to :scrape
end
