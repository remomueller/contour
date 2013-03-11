require 'omniauth'
require 'omniauth-ldap'

# # Overwriting methods from Rack
# # While OmniAuth 1.0.2 fixes the Builder setup, Rack 1.4.0 still responds incorrectly to it's release version.
# # Wait for Rack 1.4.1 or updated version before removing the Builder fixes
# module OmniAuth

#   # class Builder updates for Rack 1.4.0
#   class Builder
#     def initialize(app = nil,&block)
#       @use, @map, @run = [], nil, app
#       instance_eval(&block) if block_given?
#     end

#     def on_failure(&block)
#       OmniAuth.config.on_failure = block
#     end

#     def configure(&block)
#       OmniAuth.configure(&block)
#     end

#     def provider(klass, *args, &block)
#       if klass.is_a?(Class)
#         middleware = klass
#       else
#         begin
#           middleware = OmniAuth::Strategies.const_get("#{OmniAuth::Utils.camelize(klass.to_s)}")
#         rescue NameError
#           raise LoadError, "Could not find matching strategy for #{klass.inspect}. You may need to install an additional gem (such as omniauth-#{klass})."
#         end
#       end

#       use middleware, *args, &block
#     end

#     def call(env)
#       to_app.call(env)
#     end
#   end
# end

# Fix for LDAP Authentication with Domains
module OmniAuth

  # Required to correctly authenticate given bind_dn and LDAP
  module LDAP
    class Adaptor
      class LdapError < StandardError; end
      class ConfigurationError < StandardError; end
      class AuthenticationError < StandardError; end
      class ConnectionError < StandardError; end

      attr_accessor :bind_dn, :password
      attr_reader :connection, :uid, :base, :auth
      def self.validate(configuration={})
        message = []
        MUST_HAVE_KEYS.each do |name|
           message << name if configuration[name].nil?
        end
        raise ArgumentError.new(message.join(",") +" MUST be provided") unless message.empty?
      end

      def bind_as(args = {})
        result = false
        ldap = @connection
        ldap.auth args[:username], args[:password]
        rs = ldap.search(base: args[:base], filter: Net::LDAP::Filter.eq(@uid, args[:username].split('\\').last.to_s))
        result = rs.first if rs
        result
      end

    end
  end

  # Required for proper script name for suburis
  # Required for appending domain option to user credentials
  module Strategies
    class LDAP
      include OmniAuth::Strategy

      option :domain, ''

      def request_phase
        OmniAuth::LDAP::Adaptor.validate @options
        f = OmniAuth::Form.new( title: (options[:title] || "LDAP Authentication"), url: "#{@env['SCRIPT_NAME']}" + callback_path ) # Modified to include @env['SCRIPT_NAME']
        f.text_field 'Login', 'username'
        f.password_field 'Password', 'password'
        f.button "Sign In"
        f.to_response
      end

      def callback_phase
        bind_dn = "#{@options[:domain] + '\\' unless @options[:domain].blank?}#{request['username']}" # Added
        @options[:bind_dn] = bind_dn if @options[:bind_dn].blank? # Added
        @adaptor = OmniAuth::LDAP::Adaptor.new @options
        raise MissingCredentialsError.new("Missing login credentials") if request['username'].nil? || request['password'].nil?
        begin
          @ldap_user_info = @adaptor.bind_as(base: @adaptor.base, username: bind_dn, password: request['password']) # Modified
          return fail!(:invalid_credentials) if !@ldap_user_info
          @user_info = self.class.map_user(@@config, @ldap_user_info)
          super
        rescue Exception => e
          return fail!(:ldap_error, e)
        end
      end
    end
  end
end
