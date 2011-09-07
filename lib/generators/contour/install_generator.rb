module Contour
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a Contour initializer"
      # class_option :orm

      def copy_initializer
        template "contour.rb", "config/initializers/contour.rb"
      end

      def copy_devise
        template "devise.rb", "config/initializers/devise.rb"
      end

      def copy_omniauth
        template "omniauth.rb", "config/initializers/omniauth.rb"
      end

      def copy_omniauth_fix
        template "omniauth_fix.rb", "config/initializers/omniauth_fix.rb"
      end
      
      def copy_rack_fix
        template "rack_fix.rb", "config/initializers/rack_fix.rb"
      end

      def add_contour_route
        contour_routes = []
        contour_routes << "match '/auth/failure' => 'contour/authentications#failure'"
        contour_routes << "match '/auth/:provider/callback' => 'contour/authentications#create'"
        contour_routes << "match '/auth/:provider' => 'contour/authentications#passthru'"
        contour_routes << "resources :authentications, :controller => 'contour/authentications'"
        contour_routes << "devise_for :users, :controllers => {:registrations => 'contour/registrations', :sessions => 'contour/sessions', :passwords => 'contour/passwords'}, :path_names => { :sign_up => 'register', :sign_in => 'login' }"
        # route "root :to => 'welcome'"
        route contour_routes.join("\n")
      end
      
      # def copy_locale
      #   copy_file "../../../config/locales/en.yml", "config/locales/contour.en.yml"
      # end
      # 
      # def show_readme
      #   readme "README" if behavior == :invoke
      # end
    end
  end
end
