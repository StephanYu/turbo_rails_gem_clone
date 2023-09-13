module TurboRailsGem::Streams::TurboStreamsTagBuilder
  private

  def turbo_stream
    TurboRailsGem::Streams::TagBuilder.new(view_context)
  end
end