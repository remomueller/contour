# Compiling the Gem
# gem build contour.gemspec
# gem install ./contour-x.x.x.gem --no-ri --no-rdoc --local
#
# gem push contour-x.x.x.gem
# gem list -r contour
# gem install contour

$LOAD_PATH.push File.expand_path('../lib', __FILE__)
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

  s.files = Dir['{app,config,db,lib}/**/*'] + %w(CHANGELOG.md contour.gemspec LICENSE Rakefile README.md)
  s.test_files = Dir['test/**/*'] - Dir['test/dummy/{tmp,log}/**/*']

  # s.add_dependency 'rails',                   '~> 5.0.0.beta1'
  # s.add_dependency 'jquery-rails',            '>= 3.0.4'
  # s.add_dependency 'coffee-rails',            '~> 4.1.0'
  # s.add_dependency 'devise',                  '~> 3.5.1'
  # s.add_dependency 'bootstrap-sass',          '~> 3.3.3'
  # s.add_dependency 'sass-rails',              '~> 5.0.3'
  # s.add_dependency 'sass',                    '~> 3.4.14'
  # s.add_dependency 'autoprefixer-rails'

  s.add_development_dependency 'sqlite3'
end
