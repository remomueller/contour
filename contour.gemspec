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
  s.version     = Contour::VERSION::STRING
  s.authors     = ['Remo Mueller']
  s.email       = 'remosm@gmail.com'
  s.homepage    = 'https://github.com/remomueller'
  s.summary     = 'Basic Rails framework files and assets for layout and authentication'
  s.description = 'Basic Rails Framework files and assets for layout and authentication'
  
  s.platform = Gem::Platform::RUBY
  
  s.add_dependency 'rails',         '~> 3.1.3'
  s.add_dependency 'devise',        '~> 1.4.9'
  s.add_dependency 'omniauth',      '=0.2.6'
  s.add_dependency 'jquery-rails',  '~> 1.0.17'
  
  s.files = Dir["{app,config,db,lib}/**/*"] + ["CHANGELOG.rdoc", "contour.gemspec", "LICENSE", "Rakefile", "README.rdoc"]
  # s.files = `git ls-files`.split("\n")
  s.test_files = Dir["test/**/*"]
end