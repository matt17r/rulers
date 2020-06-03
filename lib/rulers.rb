require 'rulers/version'
require 'rulers/array'
require 'rulers/object'

module Rulers
  class Application
    def call(env)
      [200, {'Content-Type' => 'text/html'},
        ['Hello from Ruby on Rulers!']]
    end
  end

  class Error < StandardError; end
end
