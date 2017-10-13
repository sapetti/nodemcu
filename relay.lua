local Module = {}

local led1 = 4;
gpio.mode(led1,gpio.OUTPUT);
gpio.write(led1, gpio.LOW);
 
local function switchRelay(_GET)      
	buf = buf.."<!doctype html>";
	buf = buf.."<html>";
	buf = buf.."<head>";
	buf = buf.."<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">";
	buf = buf.."</head>";
	buf = buf.."<body>";
	buf = buf.."<h1> Riego automatico </h1>";
	buf = buf.."<p>Riego ";
	--local _on,_off = "",""
	if(_GET.pin == "ON1")then
		gpio.write(led1, gpio.HIGH);
		buf = buf.."<a href=\"?pin=OFF1\"><button>OFF</button></a>";
	else
		gpio.write(led1, gpio.LOW);
		buf = buf.."<a href=\"?pin=ON1\"><button>ON</button></a>";
	end
	buf = buf.."</p>";
	buf = buf.."</body>";
	
	return buf;
end

Module.switchRelay = switchRelay
 
return Module