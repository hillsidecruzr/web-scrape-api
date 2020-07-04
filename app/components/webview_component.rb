class WebviewComponent < ViewComponent::Base
  def initialize(markup:)
    @markup = markup.try(:html_safe)
  end

private

  attr_reader :markup
end