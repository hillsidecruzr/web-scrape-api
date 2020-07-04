module Service
  module Concerns
    module Parsable
      extend ::ActiveSupport::Concern

      class_methods do
        def parsable
          Proc.new(&method(:parse))
        end

        def parse(markup)
          Nokogiri::HTML.parse(markup)
        end
      end

      included do
        def parsable
          self.class.parsable
        end

        def parse(markup)
          self.class.parse markup
        end
      end
    end
  end
end