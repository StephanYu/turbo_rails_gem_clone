module TurboRailsGem
  class Engine < ::Rails::Engine
    isolate_namespace TurboRailsGem

    initializer "turbo_rails_gem.helpers" do
      ActiveSupport.on_load(:action_controller_base) do
        helper TurboRailsGem::Engine.helpers
      end
    end

    initializer "turbo_rails_gem.media_type" do
      Mime::Type.register "text/vnd.turbo-stream.html", :turbo_stream
    end
  end
end
