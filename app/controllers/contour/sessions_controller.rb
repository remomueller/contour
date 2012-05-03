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

  # Overwrite Devise authentication to check if the user is typing another credential into the default box
  # if so, find alternative login methods for that user and forward the user to those login screens
  def create
    # resource = warden.authenticate!(auth_options)
    resource = warden.authenticate(auth_options)

    if resource
      set_flash_message(:notice, :signed_in) if is_navigational_format?
      sign_in(resource_name, resource)
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      resource = resource_name.to_s.titleize.constantize.find_by_email(params[resource_name][:email])
      if resource and resource.respond_to?('authentications') and providers = resource.authentications.pluck(:provider).uniq and providers.size > 0
        redirect_to request.script_name + '/auth/' + providers.first
      elsif providers = Authentication.where(uid: params[resource_name][:email]).pluck(:provider).uniq and providers.size > 0
        redirect_to request.script_name + '/auth/' + providers.first
      else
        resource = warden.authenticate!(auth_options)
      end
    end
  end

end
