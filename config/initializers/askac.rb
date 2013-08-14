require 'ext/string'
require 'ext/auto_translation'

Geoip = GeoIP.new("db/GeoIP.dat")
HTMLCoder = HTMLEntities.new