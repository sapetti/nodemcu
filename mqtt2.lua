wifi.setmode(wifi.STATION);
wifi.sta.config("[[SSID]]","[[PASSWORD]]");
srv=net.createServer(net.TCP);

print(wifi.sta.getip());

mqtt = mqtt.Client("client_id", 1200, "username", "password")

-- on receive message
mqtt:on("message", function(conn, topic, data)
  print(topic .. ":" )
  if data ~= nil then
    print(data)
  end
end)

mqtt:connect("[[SERVER_IP]]", [[PORT]], 0, function(conn) 
  print("connected")
  -- subscribe topic with qos = 0
  mqtt:subscribe("my_topic",0, function(conn) 
    -- publish a message with data = my_message, QoS = 0, retain = 0
    mqtt:publish("my_topic","my_message",0,0, function(conn) 
      print("sent") 
    end)
  end)
end)