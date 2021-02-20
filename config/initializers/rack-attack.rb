class Rack::Attack
  ALLOW_IP_ADDRESS = '192.168.0.2'
  blocklist('only allow from admin') do |req|
    req.path.match(%r{^/admin}) && req.path.match(%r{^/adminusers}) && (ALLOW_IP_ADDRESS != req.ip)
  end
end