module TurboRailsGem::StreamsHelper
  def turbo_stream
    TurboRailsGem::Streams::TagBuilder.new(self)
  end

  def turbo_stream_from(*streamables, **attributes)
    attributes[:channel] = "TurboRailsGem::StreamsChannel"
    attributes[:"signed-stream-name"] = TurboRailsGem::StreamsChannel.stream_name_from(streamables)

    tag.turbo_cable_stream_source(**attributes)
  end
end