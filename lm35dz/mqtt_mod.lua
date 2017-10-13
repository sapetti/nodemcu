local mqtt_module = {}
local m = {}

local MQTT_SERVER = "[[SERVER_ID]]"
local CLIENT_ID = "NodeMCU1"
local ROOM = "/ROOM1"
local NODE_ID = ROOM .. "/" .. CLIENT_ID
local TEMPERATURE = "/temperature"
local IRRIGATION = "/irrigation"
local REGISTER = "/register"
local LIGHT = "/light"
local SERVICES = "/services"
local SERVICES_AVAILABLE = {SERVICES, TEMPERATURE, IRRIGATION, LIGHT}
local OFFLINE = "offline"
local TEMPERATURE_PIN = 2
local LIGHT_PIN = 3
local RELAY_PIN = 4

gpio.mode(TEMPERATURE_PIN, gpio.INPUT)
gpio.mode(LIGHT_PIN, gpio.OUTPUT)
gpio.write(LIGHT_PIN, gpio.LOW)
gpio.mode(RELAY_PIN, gpio.OUTPUT)
gpio.write(RELAY_PIN, gpio.LOW)


function mqtt_module.start()  

  -- Initialize
  m = mqtt.Client(CLIENT_ID, 120, "", "")

  -- Connect to server
  m:connect(MQTT_SERVER, 1883, 0, 1, function(client) 
    print("Connected to server") 
    
    -- Register node name
    m:publish(REGISTER, NODE_ID, 0, 0)

    --tmr.delay(100)

    srvc = ""
    for index = 1, #SERVICES_AVAILABLE do
      srvc = "" .. SERVICES_AVAILABLE[index]
      print ("Service:" .. index .. " " .. NODE_ID .. srvc)
      
      -- Subscribe services availables
      m:subscribe(NODE_ID .. srvc, 0) --, function(client) print(srvc .. " registered") end)
    end
    
    -- Handle messages
    m:on("message", function(client, topic, data)  dispatch(topic, data) end)

  end,

  -- Error handling on connection
  function(client, reason) 
    print("Failed reason: "..reason) 
  end)

  -- Debug disconnect
  m:on(OFFLINE, function(client) print (OFFLINE) end)
  --m:lwt("/lwt", OFFLINE, 0, 0)
  
end

function measureTemperature()
  local r = gpio.read(TEMPERATURE_PIN)
  local temp = r * 28500 / 1024
  print("Temperature returned: " .. temp)
  m:publish(NODE_ID .. TEMPERATURE .. "/value", temp, 0, 0)
end 

function irrigate(secs)
  print("Irrigation started for " .. json.secs .. " seconds")
  gpio.write(RELAY_PIN, gpio.HIGH)
  tmr.delay(secs * 1000 * 10)
  gpio.write(RELAY_PIN, gpio.LOW)
  m:publish(NODE_ID .. IRRIGATION .. "/completed", temp, 0, 0)
  print("Irrigation stoped")
end

function powerLight(status)
  print("Set light to " .. status)
  if(status == "on") then
    gpio.write(LIGHT_PIN, gpio.HIGH)
  else
    gpio.write(LIGHT_PIN, gpio.LOW)
  end
end

function listServices()
  srvcs = "{ \"services\" : ["
  for index = 1, #SERVICES_AVAILABLE do
    srvcs = srvcs .. "\"" .. SERVICES_AVAILABLE[index] .. "\","
  end
  srvcs = srvcs .. "]}"
  print(srvcs)
  m:publish(NODE_ID .. SERVICES .. "/value", cjson.encode({services = SERVICES_AVAILABLE}), 0, 0)
end

function dispatch(topic, payload)
    print(topic .. ":" .. payload)
    local json = nil 
    if payload == nil then 
        json = {} 
    else 
        json = cjson.decode(payload) 
    end
    
    if topic == NODE_ID .. SERVICES then listServices()
    elseif topic == NODE_ID .. IRRIGATION then irrigate(json.secs)
    elseif topic == NODE_ID .. TEMPERATURE then measureTemperature()
    elseif topic == NODE_ID .. LIGHT then powerLight(json.status)
    elseif topic == NODE_ID .. "/ping" then print("Pong")
    else 
      print("Topic " .. topic .. " not listed")
      m:publish(NODE_ID .. "/error", "Topic " .. topic .. " not listed", 0, 0)
    end
end
 
return mqtt_module
