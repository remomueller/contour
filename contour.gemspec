# Compiling the Gem
# gem build contour.gemspec
# [sudo] gem install ./contour-x.x.x.gem
#
# gem push contour-x.x.x.gem
# gem list -r contour
# gem install contour

$:.push File.expand_path("../lib", __FILE__)
require "contour/version"

Gem::Specification.new do |s|
  s.name = "contour"
  s.version = Contour::VERSION.dup
  s.platform = Gem::Platform::RUBY
  s.summary = "Basic Rails framework files and assets for layout and authentication"
  s.email = "remosm@gmail.com"
  s.homepage = "https://github.com/remomueller"
  s.authors = ["Remo Mueller"]
  
  s.description = "Basic Rails Framework files and assets for layout and authentication"
  
  s.files = ["CHANGELOG.rdoc","LICENSE","README.rdoc",
             "app/controllers/contour/samples_controller.rb",
             "app/views/contour/layouts/application.html.erb",
             "app/views/contour/samples/index.html.erb",
             "lib/contour.rb",
             "lib/contour/engine.rb",
             "lib/contour/version.rb"]
end