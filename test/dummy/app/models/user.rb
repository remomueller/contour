# rails g model Authentication user_id:integer provider:string uid:string
# rails g migration CreateUsers first_name:string last_name:string

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable

  # # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name

  # Named Scopes
  scope :current, -> { where(deleted: false) }

  def name
    "#{first_name} #{last_name}"
  end

  def reverse_name
    "#{last_name}, #{first_name}"
  end

  # Overriding Devise built-in active? method
  def active_for_authentication?
    super and self.status == 'active' and not self.deleted?
  end

end
