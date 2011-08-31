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

  # s.add_development_dependency "rails",   "~> 3.0"
  s.add_dependency("devise", "~> 1.3.4")
  s.add_dependency("omniauth", "0.2.6")
  
  s.files = `git ls-files`.split("\n")
end