# Compiling the Gem
# gem build contour.gemspec
# [sudo] gem install ./contour-x.x.x.gem
#
# gem push contour-x.x.x.gem
# gem list -r contour
# gem install contour

$:.push File.expand_path('../lib', __FILE__)
require 'contour/version'

Gem::Specification.new do |s|
  s.name = 'contour'
  s.version = Contour::VERSION::STRING
  s.platform = Gem::Platform::RUBY
  s.summary = 'Basic Rails framework files and assets for layout and authentication'
  s.email = 'remosm@gmail.com'
  s.homepage = 'https://github.com/remomueller'
  s.authors = ['Remo Mueller']
  s.description = 'Basic Rails Framework files and assets for layout and authentication'

  s.add_dependency('devise', '~> 1.4.9')
  s.add_dependency('omniauth', '=0.2.6')
  # jquery-rails 1.0.17 switches to jQuery 1.7.0
  # HighCharts 2.1.4 requires jQuery 1.6.4
  s.add_dependency('jquery-rails', '>= 1.0.0', '<= 1.0.16')
  
  s.files = `git ls-files`.split("\n")
end