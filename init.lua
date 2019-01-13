uart.setup(0,115200,8,0,1,0)
clearPin = 1 --Clear button pin, pull low to activate, nuke settings, and start wifi setup
gpio.mode(clearPin,gpio.INPUT,gpio.PULLUP)

idePin = 2 --Web IDE button pin, pull low to activate, and start in the NodeMCU web IDE
gpio.mode(idePin,gpio.INPUT,gpio.PULLUP)
 
print("\n\n\n\n\nStarting up...")

-- Check if we're holding the clear button
if (gpio.read(clearPin)==gpio.LOW) then 
	print("Starting the wifi end user config.")
    gpio.mode(4, gpio.OUTPUT);
	tmr.alarm(1,125,1,function() if gpio.read(4)==gpio.LOW then gpio.write(4,gpio.HIGH) else gpio.write(4,gpio.LOW) end end); --blink fast
	wifi.sta.clearconfig(); --nuke network settings
	
    -- If you have other thigns to clear such as deleting a saved settings file, do it here.
    
	enduser_setup.start(
		function()
			print("Connected to wifi! IP: " .. wifi.sta.getip());
			tmr.alarm(2, 5000, tmr.ALARM_SINGLE, function() node.restart() end);
		end,
		function(err, str)
			print("enduser_setup: Err #" .. err .. ": " .. str);
		end,
		print
	);
	
--check to see if we're holding down the web IDE button
elseif (gpio.read(idePin)==gpio.LOW) then
	if file.exists("ide.lua") then
	    print("Starting the web IDE interface. (Script form)")
        dofile("ide.lua")
    elseif file.exists("ide.lc") then
	    print("Starting the web IDE interface. (Compiled form)")
        dofile("ide.lc")
    else 
        print("Couldn't find web IDE files.  Starting the main program instead.")
        tmr.alarm(0, 1000, 0, function() dofile("main.lua") end)
    end

--neither button, run main.lua
else
	if file.exists("main.lua") then
	    print("Starting main.lua.")
        tmr.alarm(0, 1000, 0, function() dofile("main.lua") end)
    else
        print("main.lua missing, starting web IDE instead.")
       	if file.exists("ide.lua") then
	        print("Starting the web IDE interface. (Script form)")
            dofile("ide.lua")
        elseif file.exists("ide.lc") then
	        print("Starting the web IDE interface. (Compiled form)")
            dofile("ide.lc")
        else
            print("No main.lua, and no web IDE? HALT.")
        end
    end
end
