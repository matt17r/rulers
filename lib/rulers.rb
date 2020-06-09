require 'rulers/constants'
require 'rulers/controller'
require 'rulers/dependencies'
require 'rulers/errors'
require 'rulers/routing'
require 'rulers/util'
require 'rulers/version'

module Rulers
  class Application
    def call(env)
      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      text = controller.send(act)
      [200, {'Content-Type' => 'text/html'}, [text]]
    rescue LoadError => e
      server_error(subject: 'Controller not found')
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
end
