# Overwriting methods from Rack
module Rack
  class Request
    def host_with_port
      if forwarded = @env["HTTP_X_FORWARDED_HOST"]
        # Rails.logger.info "\n\nContour::Fixes Rack::Request::host_with_port"
        # Rails.logger.info "@env[HTTP_X_FORWARDED_HOST]: #{@env["HTTP_X_FORWARDED_HOST"]} USING: #{forwarded.split(/,\s?/).first}\n\n"
        # forwarded.split(/,\s?/).last
        # changed forwarded to first since we don't want the internal IP.
        forwarded.split(/,\s?/).first
      else
        @env['HTTP_HOST'] || "#{@env['SERVER_NAME'] || @env['SERVER_ADDR']}:#{@env['SERVER_PORT']}"
      end
    end
  end


  # Required as Rack 1.5.x series removed the default content type of text/html for some unknown reason, something about "adhering to standards for HTTP 1.0 and 1.1 protocols"
  # Was removed in this commit: https://github.com/rack/rack/commit/3623d04526b953a63bfb3e72de2d6920a042563f#L2L21
  class Response
    def initialize(body=[], status=200, header={})
      @status = status.to_i
      @header = Utils::HeaderHash.new("Content-Type" => "text/html").merge(header) # This is the modified line that requires Content-Type set to text/html.

      @chunked = "chunked" == @header['Transfer-Encoding']
      @writer  = lambda { |x| @body << x }
      @block   = nil
      @length  = 0

      @body = []

      if body.respond_to? :to_str
        write body.to_str
      elsif body.respond_to?(:each)
        body.each { |part|
          write part.to_s
        }
      else
        raise TypeError, "stringable or iterable required"
      end

      yield self  if block_given?
    end
  end
end
