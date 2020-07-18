module Service
  module Concerns
    module Fetchable
      extend ActiveSupport::Concern

      class_methods do
        def fetchable
          Proc.new(&method(:fetch))
        end

        def fetch(stringify = true, url)
          response = Faraday.get url

          return response.body if (response.status == 200 && stringify)

          ""
        end
      end

      included do
        self.attr_reader :markup

        def fetchable
          self.class.fetchable
        end

        def fetch(stringify = true, url)
          @markup = self.class.fetch(stringify, url)
        end
      end
    end
  end
end