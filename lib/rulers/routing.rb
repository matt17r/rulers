module Rulers
  class Application
    def get_controller_and_action(env)
      _, cont, action, after = env["PATH_INFO"].split('/', 4)
      raise FileNotFoundError if cont == 'Favicon.ico'
      cont = 'home' if cont.blank?
      action = 'index' if action.blank?
      cont = cont.capitalize + "Controller"
      [Object.const_get(cont), action]
    rescue NameError
      raise ControllerNotFoundError, "Controller <code>#{cont}</code> not found"
    end
  end
end
