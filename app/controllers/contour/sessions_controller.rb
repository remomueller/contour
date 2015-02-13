class Contour::SessionsController < Devise::SessionsController

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
