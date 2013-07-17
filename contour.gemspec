# Compiling the Gem
# gem build contour.gemspec
# gem install ./contour-x.x.x.gem --no-ri --no-rdoc --local
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
  s.license     = 'CC BY-NC-SA 3.0'

  s.platform = Gem::Platform::RUBY

  s.files = Dir['{app,config,db,lib}/**/*'] + ['CHANGELOG.md', 'contour.gemspec', 'LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails',                   '~> 4.0.0'
  s.add_dependency 'jquery-rails',            '>= 2.2.2'
  s.add_dependency 'coffee-rails',            '~> 4.0.0'
  s.add_dependency 'devise',                  '~> 3.0.0'
  s.add_dependency 'omniauth',                '~> 1.1.3'
  s.add_dependency 'omniauth-cas',            '~> 1.0.1'
  s.add_dependency 'omniauth-facebook',       '~> 1.4.1'
  s.add_dependency 'omniauth-ldap',           '~> 1.0.3'
  s.add_dependency 'omniauth-linkedin',       '~> 0.1.0'
  s.add_dependency 'omniauth-openid',         '~> 1.0.1'
  s.add_dependency 'omniauth-twitter',        '~> 0.0.14'

  s.add_development_dependency 'sqlite3'
end
