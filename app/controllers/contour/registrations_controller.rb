class Contour::RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :require_no_authentication, only: [ :new ]
  before_filter :configure_permitted_parameters

  def create
    if signed_in?
      # TODO: Should use "Resource" and not "User"
      params[:user][:password] = params[:user][:password_confirmation] = Digest::SHA1.hexdigest(Time.now.usec.to_s)[0..19] if params[:user][:password].blank? and params[:user][:password_confirmation].blank?

      # self.resource = build_resource
      @user = build_resource

      if @user.save
        respond_to do |format|
          format.html { redirect_to @user, notice: 'User was successfully created.' }
          format.json { render json: @user.as_json( only: ([ :id, :email, :authentication_token ] | Contour::sign_up_fields.collect{|a| a[:attribute].to_sym}) ), status: :created, location: @user }
        end
      else
        respond_to do |format|
          format.html { render action: "/users/new" }
          format.json { render json: @user.errors, status: :unprocessable_entity}
        end
      end
    elsif spam_field_used?
      Rails.logger.info "SPAM BOT SIGNUP: #{params.inspect}"
      self.resource = build_resource
      redirect_to new_session_path(resource), notice: 'Thank you for your interest! Due to limited capacity you have been put on a waiting list. We will email you when we open up additional space.'
    else
      super
      session[:omniauth] = nil if @user and not @user.new_record?
    end
  end

  protected

    def configure_permitted_parameters
      permitted_fields = Contour::sign_up_fields.collect{|a| a[:attribute].to_sym}  | [ :email, :password, :password_confirmation ]
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(*permitted_fields) }
    end

    def build_resource(hash=nil)
      object = super(hash)
      if session[:omniauth]
        @user.apply_omniauth(session[:omniauth])
        @user.valid?
      end
      object
    end

    def after_inactive_sign_up_path_for(resource)
      new_session_path(resource) # root_path
    end

    def spam_field_used?
      Contour::spam_fields.select{|spam_field| (params[:user] and not params[:user][spam_field].blank?) }.size > 0
    end

end
