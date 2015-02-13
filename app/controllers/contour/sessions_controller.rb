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

  # Overwrite devise to provide JSON responses as well
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_to do |format|
      format.html { respond_with resource, location: after_sign_in_path_for(resource) }
      format.json { render json: { success: true, resource_name => { id: resource.id, email: resource.email, first_name: resource.first_name, last_name: resource.last_name, authentication_token: (resource.respond_to?(:authentication_token) ? resource.authentication_token : nil) } } }
    end
  end

end
