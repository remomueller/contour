module Contour
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a Contour initializer"
      class_option :orm

      def copy_initializer
        template "contour.rb", "config/initializers/contour.rb"
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
