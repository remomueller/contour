class Contour::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  desc "Install default Contour Files"
  # class_option :orm

  def copy_initializer
    template "contour.rb", "config/initializers/contour.rb"
  end

  def install_devise
    generate("devise:install")
    model_name = ask("What would you like the user model to be called? [user]")
    model_name = "user" if model_name.blank?
    generate("devise", model_name)
    route "devise_for :#{model_name}s, controllers: { registrations: 'contour/registrations', sessions: 'contour/sessions', passwords: 'contour/passwords', confirmations: 'contour/confirmations', unlocks: 'contour/unlocks' }, path_names: { sign_up: 'register', sign_in: 'login' }"
  end

  def show_readme
    readme "README" if behavior == :invoke
  end

  # def copy_locale
  #   copy_file "../../../config/locales/en.yml", "config/locales/contour.en.yml"
  # end
end
