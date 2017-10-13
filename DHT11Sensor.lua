-- Reference https://github.com/ok1cdj
pin = 3

local Mod = {} 

Humidity = 0
HumidityDec=0
Temperature = 0
TemperatureDec=0
Checksum = 0
ChecksumTest=0


local function getTemp()
	print("getTemp");
	buf = "";
	buf = buf.."<!doctype html>";
	buf = buf.."<html>";
	buf = buf.."<head>";
	buf = buf.."<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">";
	buf = buf.."</head>";
	buf = buf.."<body>";
	buf = buf.."<p>";
	
	status, temp, humi, temp_dec, humi_dec = dht.read11(pin)
	if status == dht.OK then
		-- Integer firmware using this example
		--buf = buf..string.format("DHT Temperature:%d.%03d;Humidity:%d.%03d\r\n",math.floor(temp),temp_dec,math.floor(humi),humi_dec)
		buf = buf..string.format("DHT Temperature:%d;Humidity:%d\r\n",temp,humi)
		-- Float firmware using this example
		print("DHT Temperature:"..temp..";".."Humidity:"..humi)

	elseif status == dht.ERROR_CHECKSUM then
		buf = buf.."DHT Checksum error.";
		print( "DHT Checksum error." );
	elseif status == dht.ERROR_TIMEOUT then
		buf = buf.."DHT timed out.";
		print( "DHT timed out." );
	end
	
	buf = buf.."</p>";	
	buf = buf.."</body>";
	return buf;
end

Mod.getTemp = getTemp
return Mod
