class Link
  include Mongoid::Document
  include Mongoid::Timestamps

  field :url, type: String
  field :external, type: Boolean
  field :occurrences, type: Integer

  belongs_to :scrape
end
