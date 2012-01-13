require 'omniauth'

# Overwriting methods from Rack
module OmniAuth

  # class Builder updates for Rack 1.4.0
  class Builder
    def initialize(app = nil,&block)
      @use, @map, @run = [], nil, app
      instance_eval(&block) if block_given?
    end
    
    def on_failure(&block)
      OmniAuth.config.on_failure = block
    end
  
    def configure(&block)
      OmniAuth.configure(&block)
    end
  
    def provider(klass, *args, &block)
      if klass.is_a?(Class)
        middleware = klass
      else
        begin
          middleware = OmniAuth::Strategies.const_get("#{OmniAuth::Utils.camelize(klass.to_s)}")
        rescue NameError
          raise LoadError, "Could not find matching strategy for #{klass.inspect}. You may need to install an additional gem (such as omniauth-#{klass})."
        end
      end
  
      use middleware, *args, &block
    end
  
    def call(env)
      to_app.call(env)
    end
  end

  module Strategies
    class LDAP
      # include OmniAuth::Strategy
      
      def initialize(app, options = {}, &block)
        # Rails.logger.debug "Contour::Fixes => Omniauth::Strategies::LDAP::initialize"
        super(app, options[:name] || :ldap, options.dup, &block)
        @name_proc = (@options.delete(:name_proc) || Proc.new {|name| name})
        @adaptor = OmniAuth::Strategies::LDAP::Adaptor.new(options)
        @domain = options[:domain] # Added
      end
      
      protected
      
      # Reroutes directly to callback_phase instead of redirecting to callback_path
      # TODO: Possibility that this could be removed in the future.
      def request_phase
        # Rails.logger.info "Contour::Fixes => Omniauth::Strategies::LDAP::request_phase Request Phase Hook"
        if env['REQUEST_METHOD'] == 'GET'
          get_credentials
        else
          session['omniauth.ldap'] = {'username' => request['username'], 'password' => request['password']}
          if true
            # Rails.logger.info "Contour::Fixes => Omniauth::Strategies::LDAP::request_phase Skipping Redirect"
            callback_phase # Added
          else
            redirect callback_path
          end
        end
      end
      
      # Includes addition of a "domain"
      def callback_phase
        failure_temp_path = "#{@env['SCRIPT_NAME']}/#{OmniAuth.config.path_prefix.split('/').last}/failure?message=invalid_credentials"
        
        begin
          creds = session['omniauth.ldap']
          session.delete 'omniauth.ldap'
          @ldap_user_info = {}
          begin
            creds['username'] = @domain.to_s + '\\' + creds['username'] unless @domain.blank?
            @adaptor.bind(:bind_dn => creds['username'], :password => creds['password'])
          rescue Exception => e
            Rails.logger.info "Failed to bind with the default credentials: " + e.message
            return redirect failure_temp_path
            # return fail!(:invalid_credentials, e)
          end
          
          @ldap_user_info = @adaptor.search( base: @adaptor.base, filter: Net::LDAP::Filter.eq(@adaptor.uid, creds['username'].split('\\').last.to_s), limit: 1 )
          @ldap_user_info.each do |key, val|
            @ldap_user_info[key] = val.first if val.class == Array and val.size == 1
          end
          
          @user_info = self.class.map_user(@@config, @ldap_user_info)
  
          @env['REQUEST_METHOD'] = 'GET'
          # @env['PATH_INFO'] = callback_path
          @env['PATH_INFO'] = "#{OmniAuth.config.path_prefix.split('/').last}/#{name}/callback"
          
          @env['omniauth.auth'] = { 'provider' => 'ldap', 'uid' => @user_info['uid'], 'info' => @user_info }
        rescue Exception => e
          Rails.logger.info "Exception in callback_phase: #{e.inspect}"
          return redirect failure_temp_path
          # return fail!(:invalid_credentials, e)
        end
        
        call_app!
      end
      
      def self.map_user mapper, object
        user = {}
        mapper.each do |key, value|
          case value
            when String
              if object[value.downcase.to_sym]
                if object[value.downcase.to_sym].kind_of?(Array)
                  user[key] = object[value.downcase.to_sym].join(', ')
                else
                  user[key] = object[value.downcase.to_sym].to_s 
                end
              end
            when Array
              # value.each {|v| (user[key] = object[v.downcase.to_sym].to_s; break;) if object[v.downcase.to_sym]}
              value.each {|v| (user[key] = object[v.downcase.to_sym].join(', '); break;) if object[v.downcase.to_sym]}
            when Hash
              value.map do |key1, value1|
                pattern = key1.dup
                value1.each_with_index do |v,i|
                  part = '';
                  v.each {|v1| (part = object[v1.downcase.to_sym].to_s; break;) if object[v1.downcase.to_sym]}
                  pattern.gsub!("%#{i}",part||'') 
                end 
                user[key] = pattern
              end
            end
          end
        user
      end
      
    end
  end
end