class Contour::RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :require_no_authentication, :only => [ :new ]
  
  def create
    if user_signed_in?
      params[:user][:password] = params[:user][:password_confirmation] = Digest::SHA1.hexdigest(Time.now.usec.to_s)[0..19]
      @user = User.new(params[:user])
      if @user.save
        [:pp_committee, :pp_committee_secretary, :steering_committee, :steering_committee_secretary, :system_admin, :status].each do |attribute|
          @user.update_attribute attribute, params[:user][attribute]
        end
        redirect_to(@user, :notice => 'User was successfully created.')
      else
        render :action => "/users/new"
      end
    else
      super
      session[:omniauth] = nil unless @user.new_record?
    end
  end
    
  private
  
  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end
end
