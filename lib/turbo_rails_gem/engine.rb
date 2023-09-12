require "turbo_rails_gem/test_assertions"

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

    initializer "turbo.test_assertions" do
      ActiveSupport.on_load :active_support_test_case do
        include TurboRailsGem::TestAssertions
      end
    end

    initializer "turbo.integration_test_request_encoding" do
      ActiveSupport.on_load :action_dispatch_integration_test do
        class ActionDispatch::RequestEncoder
          class TurboStreamEncoder < IdentityEncoder
            header = [Mime[:turbo_stream], Mime[:html]].join(",")
            define_method(:accept_header) { header }
          end

          @encoders[:turbo_stream] = TurboStreamEncoder.new
        end
      end
    end
  end
end
