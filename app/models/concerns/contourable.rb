module Contourable
  extend ActiveSupport::Concern

  included do
    has_many :authentications
  end

  def apply_omniauth(omniauth)
    unless omniauth['info'].blank?
      self.email = omniauth['info']['email'] if email.blank?
    end
    self.password = Devise.friendly_token[0,20] if self.password.blank?
    authentications.build( provider: omniauth['provider'], uid: omniauth['uid'] )
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
end
