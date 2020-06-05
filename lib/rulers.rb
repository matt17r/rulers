require 'rulers/array'
require 'rulers/object'
require 'rulers/routing'
require 'rulers/version'

module Rulers
  class Application
    def call(env)
      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      text = controller.send(act)
      [200, {'Content-Type' => 'text/html'}, [text]]
    rescue ControllerNotFoundError => e
      server_error(subject: e.message)
    rescue FileNotFoundError
      [404, {'Content-Type' => 'text/html'}, []]
    rescue NoMethodError
      msg = "Action <code>#{act}</code> not found in <code>#{klass}</code>"
      server_error(subject: msg)
    end

    private

    def server_error(subject:, body: nil)
      [500, {'Content-Type' => 'text/html'}, [
        %(
          <html>
            <head>
              <title>Oh no!!! Server Error!</title>
            </head>
            <body>
              <h1>#{subject}</h1>
              <p>#{body}</p>
            </body>
          </html>
        )
        ]]
    end
  end

  class Controller
    def initialize(env)
      @env = env
    end

    def env
      @env
    end
  end

  class ControllerNotFoundError < StandardError; end
  class FileNotFoundError < StandardError; end
end
