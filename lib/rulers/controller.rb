require 'erubis'

module Rulers
  class Controller

    def initialize(env)
      @env = env
    end

    def env
      @env
    end

    def controller_name
      klass = self.class
      klass = klass.to_s.gsub(/Controller$/, '')
      Rulers.to_underscore klass
    end

    def render(view_name, locals = {})
      filename = File.join 'app', 'views', controller_name, "#{view_name}.html.erb"
      template = File.read filename
      eruby = Erubis::Eruby.new(template)
      self.instance_variables.each do |v|
        eruby.instance_variable_set(v, self.instance_variable_get(v))
      end
      debug = {
        server: env['SERVER_SOFTWARE'],
        url: env['REQUEST_URI'],
        host: env['HTTP_HOST'],
        path: env['REQUEST_PATH'],
        method: env['REQUEST_METHOD'],
        version: Rulers::VERSION,
        controller: controller_name,
        view: view_name.to_s,
        instance_variables: self.instance_variables,
      }
      eruby.result locals.merge(debug: debug)
    end
  end
end
