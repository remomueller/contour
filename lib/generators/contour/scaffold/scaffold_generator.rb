require 'rails/generators'
require 'rails/generators/generated_attribute'

class Contour::ScaffoldGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  argument :name

  # "project_user"
  def resource_name
    name.underscore
  end

  # "ProjectUser"
  def resource_class_name
    resource_name.camelize
  end

  # "ProjectUsers"
  def resource_class_name_plural
    resource_name.camelize.pluralize
  end

  # "project_users"
  def resource_name_plural
    resource_name.pluralize
  end

  # "Project User"
  def resource_title
    resource_name.titleize
  end

  # "Project Users"
  def resource_title_plural
    resource_title.pluralize
  end

  def columns
    begin
      resource_name.camelize.constantize.columns.reject{|c| ['id', 'created_at', 'updated_at'].include?(c.name)}.collect{|c| ::Rails::Generators::GeneratedAttribute.new(c.name, c.type)}
    rescue NoMethodError
      []
    end
  end

  def date_columns
    self.columns.select{|c| c.field_type == :date_select}
  end

  def generate_views
    ['_form.html.erb', 'new.html.erb', 'edit.html.erb', 'show.html.erb', 'index.html.erb'].each do |view|
      template view, "app/views/#{resource_name_plural}/#{view}"
    end
    template '_paginate.html.erb', "app/views/#{resource_name_plural}/_#{resource_name_plural}.html.erb"
    template 'controller.rb', "app/controllers/#{resource_name_plural}_controller.rb"
  end
end
