class Contour::SessionsController < Devise::SessionsController
  
  def new
    @news_feed = ''
    unless Contour.news_feed.blank?
      begin
        open(Contour.news_feed) do |http|
          response = http.read
          @news_feed = RSS::Parser.parse(response, false)
        end
      rescue => e
        logger.info "\n\nRSS Feed #{NEWS_FEED.to_s}\nRSS Feed Error: #{e}\n\n"
      end
    end
    
    super
  end
  
end