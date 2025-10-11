class LogClickJob < ApplicationJob
  queue_as :default

  def perform(url_id, ip, referrer)
    url = Url.find(url_id)
    url.increment!(:clicks)
    url.clicks.create(ip_address: ip, referrer: referrer)
  end
end
