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

  s.add_dependency 'rails',                   '~> 3.2.0'
  s.add_dependency 'jquery-rails',            '~> 2.0.0'
  s.add_dependency 'devise',                  '~> 2.0.0.rc' #'~> 1.5.3'
  s.add_dependency 'omniauth',                '~> 1.0.2'
  s.add_dependency 'omniauth-openid',         '~> 1.0.1'
  s.add_dependency 'omniauth-ldap',           '~> 1.0.2'
  s.add_dependency 'omniauth-twitter',        '~> 0.0.7'
  s.add_dependency 'omniauth-facebook',       '~> 1.2.0'
  s.add_dependency 'omniauth-linkedin',       '~> 0.0.6'
  s.add_dependency 'omniauth-cas',            '~> 0.0.3'

  s.files = Dir["{app,config,db,lib}/**/*"] + ["CHANGELOG.rdoc", "contour.gemspec", "LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
end