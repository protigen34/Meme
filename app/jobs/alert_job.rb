class AlertJob < ApplicationJob
  queue_as :medication_alerts

  def perform(mt)
    AlertChannel.broadcast_to(AlertChannel::STREAM_NAME, :message => mt.get_toast_data)
  end
end
