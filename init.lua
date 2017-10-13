wifi.setmode(wifi.STATION);
wifi.sta.config("[[SSID]]","[[PASSWORD]]");
srv=net.createServer(net.TCP);

--local relayModule = require("scripts.relay");
--local dht11Module = require("scripts.DHT11Sensor");

--srv:listen(80,function(conn)
--    conn:on("receive", function(client,request)
--        local buf = "";
--        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
--        if(method == nil)then
--            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
--        end
--        local _GET = {}
--        if (vars ~= nil)then
--            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
--                _GET[k] = v
--            end
--        end
--		if(string.find(request, "favicon.ico") == nil)then
--			print("Path:: "..path)
--			--if(_GET.pin)then
--			--	buf = relayModule.switchRelay(_GET);
--			--end
--			--if(_GET.dht11)then
--				buf = dht11Module.getTemp()
--			--end
--		end

--        client:send(buf);
--        client:close();
--        collectgarbage();
--    end)
--end)

--local mqtt = require("scripts.mqtt");

-- initiate the mqtt client and set keepalive timer to 120sec
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