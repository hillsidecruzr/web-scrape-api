class ApplicationController < ActionController::Base
  include Service::Concerns::Fetchable
  include Service::Concerns::Parsable

  attr_reader :markup
  helper_method :markup

  def index
    fetch
  end

private

  def url_param
    params.require(:url)
  end

  def fetch
    document = (fetchable >> parsable).call(url_param)

    @markup ||= document.css(:head).inner_html + document.css(:body).inner_html
  end
end