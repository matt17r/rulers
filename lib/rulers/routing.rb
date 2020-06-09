module Rulers

  ICON_FILES_TO_IGNORE = [
    'favicon.ico',
    'apple-touch-icon-precomposed.png',
    'apple-touch-icon.png',
  ]

  class Application
    def get_controller_and_action(env)
      _, cont, action, after = env["PATH_INFO"].split('/', 4)
      raise FileNotFoundError if ICON_FILES_TO_IGNORE.include?(cont.downcase)
      cont = DEFAULT_CONTROLLER if cont.blank?
      action = DEFAULT_ACTION if action.blank?
      cont = cont.capitalize + "Controller"
      [Object.const_get(cont), action]
    rescue NameError
      raise ControllerNotFoundError, "Controller <code>#{cont}</code> not found"
    end
  end
end
