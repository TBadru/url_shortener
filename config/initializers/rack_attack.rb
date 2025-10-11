class Rack::Attack
  throttle("requests by ip", limit: 5, period: 10.seconds) do |req|
    req.ip
  end

  self.throttled_responder = lambda do |request|
    [ 429, { "Content-Type" => "application/json" }, [ { error: "Too many requests" }.to_json ] ]
  end
end
