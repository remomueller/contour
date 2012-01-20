require 'rss/2.0'
require 'open-uri'

class Contour::SessionsController < Devise::SessionsController

  def new
    @news_feed = ''
    unless Contour.news_feed.blank?
      begin
        open(Contour.news_feed, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
          response = http.read
          @news_feed = RSS::Parser.parse(response, false)
        end
      rescue => e
        logger.info "\n\nRSS Feed #{Contour.news_feed}\nRSS Feed Error: #{e}\n\n"
      end
    end

    super
  end

end