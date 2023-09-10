module TurboRailsGem::StreamsHelper
  def turbo_stream
    TurboRailsGem::Streams::TagBuilder.new(self)
  end
end