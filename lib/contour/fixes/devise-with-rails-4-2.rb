module ActionDispatch::Routing
  class Mapper

    protected
      def with_devise_exclusive_scope(new_path, new_as, options) #:nodoc:
        current_scope = @scope.dup

        exclusive = { as: new_as, path: new_path, module: nil }
        exclusive.merge!(options.slice(:constraints, :defaults, :options))

        exclusive.each_pair { |key, value| @scope[key] = value }
        yield
      ensure
        @scope = current_scope
      end
  end
end
