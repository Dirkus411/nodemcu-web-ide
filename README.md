# nodemcu-web-ide
Simple Web IDE running on NodeMCU Lua

Originaly written by XChip in February 2015 and published in
http://www.esp8266.com/viewtopic.php?f=19&t=1549

Picked up by Petr Stehlík in October 2016, updated for recent NodeMCU based on SDK 1.5.x, fixed async socket:send issues, cleaned up and started improving.

https://github.com/joysfera/nodemcu-web-ide

Further improvments by Dirk van den Brink in January of 2019

### Usage
This IDE requires you to have the NodeMCU firmware, with the following modules
compiled in at minimum:

enduser_setup, file, gpio, net, node, tmr, uart, wifi

* To set up the Wi-Fi connection, hold pin 1 low on boot.  You can then connect 
to the "SetupGadget_xxxxxx" network from another device, and then open 
http://192.168.4.1 on your web browser.  The Wi-Fi setup should be pretty 
straight forward from there.  Be sure to note the IP address the device is
given on the last screen of the Wi-Fi setup.  You'll need it later. 

* To start up in the web based IDE, hold pin 2 low on boot.  After about 5-10
seconds, open the IP address from the last screen of the Wi-Fi setup in your 
web browser.  From there, operation should be pretty obvious.  You can find
all the keyboard shortcuts for the Ace code editor here:

>https://github.com/ajaxorg/ace/wiki/Default-Keyboard-Shortcuts

>You can also run simple one-line commands from the "Direct Command Execution" 
>text box on the main page of the IDE.  Please note that the output is limited 
>to the 3 seconds immediately after the command is run.  In some cases, this 
>might not be enough to capture the entire output of the command.  If you have 
>further output that you need to monitor, you may want to write the output to 
>a file instead of to the standard output.  (i.e., open a file and use 
>file.writeline() instead of print() for output.)  This way of executing
>commands is more like running a file than using the serial console.  For
>instance, you can't use "=node.heap()", you have to use "print(node.heap())"
>instead.

* To run your own program on boot, leave both pins 1 and 2 either floating or 
pulled high, and name your program "main.lua".  If this file is not present, 
the unit will boot into the web IDE instead.  

### Using SD cards attached via SPI
BONUS: If you have the spi module and FatFS support compiled into the NodeMCU
firmware, and have an SD card reader connected to the default SPI pins, you
can run "pathSD0.lua" to switch to the SD card file system.  You'll need to 
refresh the main page to see the file system from there.  This script will try
to automatically add "pathFlash.lua" to the card so you can switch back to the
internal flash.  Note that if you change your path while a program is running
in the background that accesses or writes files, this will cause unexpected 
behavior unless you explicitly declare the entire path of the file in your
program. To avoid this be sure to use file.open("/SD0/something.log") or
file.open("/FLASH/savedSettings.lua") versus just file.open("something.log") for 
instance. Also, if your program unmounts the SD card while your path is set to
it, it will crash everything and reboot. Keep this in mind! Also, note that 
the Total/Used/Remaining storage space is actually expressed in Kilobyltes, 
not Bytes when on the SD card.  All other file sizes are expressed in Bytes.

### ToDo: Upcoming features! 
Assuming I ever get time to do these things, I want to...
* organize the file list alphabetically, instead of the random AF order they currently appear in.
* Add more integrated support for SD cards, such as another file list on the main page if an SD card is present.  
