require 'devise'

# module Devise
#   class FailureApp < ActionController::Metal
#     def http_auth
#       self.status = 403
#       self.headers["WWW-Authenticate"] = %(Basic realm=#{Devise.http_authentication_realm.inspect})
#       self.content_type = request.format.to_s
#       self.response_body = http_auth_body
#     end
#   end
# end