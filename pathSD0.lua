spi.setup(1, spi.MASTER, spi.CPOL_LOW, spi.CPHA_LOW, 8, 8)
print("switching to SD0...")
vol=file.mount("/SD0");
if vol then
    file.chdir('/SD0');
    print("Done!")
    if not file.exists("pathFlash.lua") then
        file.open("pathFlash.lua","w")
        file.writeline("print(\"Switching to internal FLASH.\")\; file.chdir(\"/FLASH\");")
        file.close()
        print("Added script for switching back to /FLASH")
    end
else
    print("Nope, that didn't work. ")
end
