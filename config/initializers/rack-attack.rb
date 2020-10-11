class Rack::Attack
  ALLOW_IP_ADDRESS = '153.228.159.39'
  blocklist('only allow from admin') do |req|
    req.path.match(%r{^/admin}) && req.path.match(%r{^/adminusers}) && (ALLOW_IP_ADDRESS != req.ip)
  end
end