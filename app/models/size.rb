class Size
  include Mongoid::Document

  field :amount, type: Integer
  field :measurement, type: String
  embedded_in :image
end
