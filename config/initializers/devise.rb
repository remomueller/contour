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
      # Until 2.1.0.rc2 is out, use the following from:
      # https://github.com/plataformatec/devise/commit/ad0aed3ba5ab58cbe2f54b1a5bd760642c1c689c
      # Thanks @josevalim !
      opts[:script_name] = Rails.application.config.relative_url_root

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
