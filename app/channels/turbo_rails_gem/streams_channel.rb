class TurboRailsGem::StreamsChannel < ActionCable::Channel::Base
  extend TurboRailsGem::Streams::StreamName
  
  def subscribed
    stream_from params[:signed_stream_name]
  end
end