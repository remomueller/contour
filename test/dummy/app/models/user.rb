# rails g model Authentication user_id:integer provider:string uid:string
# rails g migration CreateUsers first_name:string last_name:string

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :encryptable, :confirmable, :lockable and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name

  # Named Scopes
  scope :current, :conditions => { :deleted => false }
  
  # Model Relationships
  has_many :authentications
  
  def name
    first_name + ' ' + last_name
  end
  
  def reverse_name
    last_name + ', ' + first_name
  end

  # Overriding Devise built-in active? method
  def active_for_authentication?
    super and self.status == 'active' and not self.deleted?
  end
  
  def apply_omniauth(omniauth)
    unless omniauth['info'].blank?
      self.email = omniauth['info']['email'] if email.blank?
      self.first_name = omniauth['info']['first_name'] if first_name.blank?
      self.last_name = omniauth['info']['last_name'] if last_name.blank?
    end
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
  
end