class AlertChannel < ApplicationCable::Channel
  STREAM_NAME = "medication_alerts".freeze
  def subscribed
    stream_from "alert:#{STREAM_NAME}"
  end

  def unsubscribed
    stop_all_streams
    # Any cleanup needed when channel is unsubscribed
  end

  def notify
  end
end
