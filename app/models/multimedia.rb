class Multimedia
  include Mongoid::Document

  field :type, type: String
  field :format, type: String
  embedded_in :link
end
