module ContourAuthenticatable
  extend ActiveSupport::Concern

  included do
    belongs_to :user
  end

  def provider_name
    OmniAuth.config.camelizations[provider.to_s.downcase] || provider.to_s.titleize
  end

end
