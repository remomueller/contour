source "https://rubygems.org"

# Declare your gem's dependencies in contour.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

gem 'devise', git: 'https://github.com/plataformatec/devise.git', ref: '2beae8e1438e2e5de201c5cbea9668af2f2e09f2' #,  branch: 'lm-rails-4-2'

# jquery-rails is used by the dummy application
gem 'jquery-rails'
# gem 'sqlite3'

# Testing
group :test do
  # Pretty printed test output
  gem 'minitest'
  gem 'minitest-reporters'
  gem 'simplecov',          '~> 0.8.2',           require: false
end

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'ruby-debug19', require: 'ruby-debug'
