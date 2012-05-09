Devise.setup do |config|
  config.router_name = :main_app
end

module Devise
  class FailureApp < ActionController::Metal

  protected

    def scope_path
      opts  = {}
      route = :"new_#{scope}_session_path"
      opts[:format] = request_format unless skip_format?
      # The 2.1.0.rc of Devise has the following line.  I've commented it out since it
      # breaks subdomain redirects when failing to login.
      # opts[:script_name] = nil

      context = send(Devise.available_router_name)

      if context.respond_to?(route)
        context.send(route, opts)
      elsif respond_to?(:root_path)
        root_path(opts)
      else
        "/"
      end
    end
  end
end
