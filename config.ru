module Rack
  class TryStatic
    def initialize app, options
      @app = app
      @try = ['', *options.delete(:try)]
      @static = ::Rack::Static.new ->{ [404, {}, []] }, options
    end

    def call env
      orig_path = env['PATH_INFO']
      found = nil

      @try.each do |path|
        resp = @static.call env.merge!({'PATH_INFO' => orig_path + path})
        if resp[0] != 404
          found = resp
          break
        end
      end

      found or @app.call env.merge!('PATH_INFO' => orig_path)
    end
  end
end

use Rack::TryStatic, root: "build", urls: ['/'], try: %w[ .html index.html /index.html ]

run ->(env) do
  not_found_page = File.expand_path("../build/404.html", File.dirname(__FILE__))

  if File.exist? not_found_page
    [ 404, { 'Content-Type' => 'text/html'}, [File.read(not_found_page)] ]
  else
    [ 404, { 'Content-Type' => 'text/html' }, ['404 - page not found'] ]
  end
end
