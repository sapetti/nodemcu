-- file : config.lua
local module = {}

module.SSID = {}  
module.SSID["[[SSID]]"] = "[[PASSWORD]]"

module.HOST = "[[HOST]]"  
module.PORT = [[PORT]]
module.ID = node.chipid()

module.ENDPOINT = "nodemcu/"  
return module  