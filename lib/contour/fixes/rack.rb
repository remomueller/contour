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
end
