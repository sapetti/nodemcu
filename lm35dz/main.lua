mqtt = require(mqtt)

wifi.setmode(wifi.STATIONAP)
wifi.ap.config({ssid="NodeMCU-01", auth=wifi.OPEN})
enduser_setup.manual(true)
enduser_setup.start(
  function()
    print("Connected to wifi as:" .. wifi.sta.getip())
    enduser_setup.stop()
    mqtt.start()
  end,
  function(err, str)
    print("enduser_setup: Err #" .. err .. ": " .. str)
  end
);