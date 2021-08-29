class SystemListenChannel < ApplicationCable::Channel
  def subscribed
    stream_from "system_listen-#{current_uuid}"
  end

  def unsubscribed
  end
end
