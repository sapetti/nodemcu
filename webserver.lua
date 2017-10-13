wifi.setmode(wifi.STATION);
wifi.sta.config("[[SSID]]","[[PASSWORD]]");
srv=net.createServer(net.TCP);

local relayModule = require("scripts.relay");
local dht11Module = require("scripts.DHT11Sensor");

srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end
        end
		if(string.find(request, "favicon.ico") == nil)then
			if(_GET.pin)then
				buf = relayModule.switchRelay(_GET);
			end
			if()then
				buf = dht11Module.getTemp()
			end
		end

        client:send(buf);
        client:close();
        collectgarbage();
    end)
end)
