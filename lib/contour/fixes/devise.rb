require 'devise'

# Devise fix for Basic Auth (Will probably be resolved when Devise moves to 2.0.0.rc2 or 2.0.0)
# Do not use deprecated ActiveSupport::Base64. Closes #1554
# https://github.com/plataformatec/devise/commit/9549a32500301c0a60a41bc31311b6198a8f0670#diff-0
module Devise
  module Strategies
    class Authenticatable < Base

    private

      # Helper to decode credentials from HTTP.
      def decode_credentials
        return [] unless request.authorization && request.authorization =~ /^Basic (.*)/m
        Base64.decode64($1).split(/:/, 2)
      end 
      
    end
  end
end