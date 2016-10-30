module Multilingual
  class Engine < ::Rails::Engine
    isolate_namespace Multilingual
    config.generators.api_only = true
  end
end
