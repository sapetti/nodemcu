wifi.setmode(wifi.STATION)
wifi.sta.config("[[SSID]]","[[PASSWORD]]")
print(wifi.sta.getip())

wifi.eventmon.register(wifi.eventmon.STA_CONNECTED, function(T) 
  print("\n\tSTA - CONNECTED".."\n\tSSID: "..T.SSID)
end)

wifi.eventmon.register(wifi.eventmon.STA_AUTHMODE_CHANGE, function(T) 
  print("\n\tSTA - AUTHMODE CHANGE".."\n\told_auth_mode: "..T.old_auth_mode.."\n\tnew_auth_mode: "..T.new_auth_mode) 
end)

wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, function(T) 
  print("\n\tSTA - GOT IP".."\n\tStation IP: "..T.IP)
  local mqtt_mod = require("mqtt_mod")
  mqtt_mod.start()
end)
