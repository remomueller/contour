module Contour
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a Contour initializer"
      # class_option :orm

      def copy_initializer
        template "contour.rb", "config/initializers/contour.rb"
      end

      # def copy_devise
      #   template "devise.rb", "config/initializers/devise.rb"
      # end

      def copy_omniauth
        template "omniauth.rb", "config/initializers/omniauth.rb"
      end

      def add_contour_route
        contour_routes = []
        # These are now included in the routes file.
        # contour_routes << "match '/auth/failure' => 'contour/authentications#failure'"
        # contour_routes << "match '/auth/:provider/callback' => 'contour/authentications#create'"
        # contour_routes << "match '/auth/:provider' => 'contour/authentications#passthru'"
        # contour_routes << "resources :authentications, :controller => 'contour/authentications'"
        # contour_routes << "devise_for :users, :controllers => {:registrations => 'contour/registrations', :sessions => 'contour/sessions', :passwords => 'contour/passwords'}, :path_names => { :sign_up => 'register', :sign_in => 'login' }"
        contour_routes.reverse.each do |contour_route|
          route contour_route
        end
      end
      
      def install_devise
        generate("devise:install")
        # model_name = ask("What would you like the user model to be called? [user]")
        # model_name = "user" if model_name.blank?
        model_name = "user"
        generate("devise", model_name)
      end

      def add_contour_devise_route
        route "devise_for :users, :controllers => {:registrations => 'contour/registrations', :sessions => 'contour/sessions', :passwords => 'contour/passwords'}, :path_names => { :sign_up => 'register', :sign_in => 'login' }"
      end

      def show_readme
        readme "README" if behavior == :invoke
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
