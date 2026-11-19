shell.run("./bios_options/colors.lua")
shell.run("delete fbios.lua")
shell.run("wget https://raw.githubusercontent.com/furbothefurryyt/bios-v4/refs/heads/main/fbios.lua")

sleep(0)

local monitor = peripheral.find("monitor")
local modem = peripheral.find("modem")
local drive = peripheral.find("drive")
local speaker = peripheral.find("speaker")
local version = 4
local subversion = 2

sleep(0)

print("(i) Running peripheral checklist...")

if monitor then
    print("(i) Monitor found.")
else
    printError("(!) No monitor found. Please turn on when fixed.")
    sleep(2)
    os.shutdown()
end

if modem then
    print("(i) Modem found.")
else
    printError("(!) No modem found. Please turn on when fixed.")
    sleep(2)
    os.shutdown()
end

if drive then
    print("(i) CD/ROM found.")
else
    printError("(!) No CD/ROM found. Please turn on when fixed.")
    sleep(2)
    os.shutdown()
end

if speaker then
    print("(i) Speaker found.")
else
    printError("(!) No speaker found. Please turn on when fixed.")
    sleep(2)
    os.shutdown()
end

print("(i) Peripheral checklist passed.")

sleep(0)

monitor.setBackgroundColor(colors.black)
monitor.setTextColor(colors.black)
monitor.setTextScale(0.5)
monitor.clear()

sleep(0)

print(drive.hasData())

if drive.hasData() == true then
    local mountPath = drive.getMountPath()
    local mainPath = fs.combine(mountPath, "startup.lua" or "main.lua" or "bootloader.lua")

    if fs.exists(mainPath) then
        print("(i) A bootable media was found! Booting...")
        os.run({}, mainPath)
    else
            printError("(!) The media inserted was invalid. Please insert a valid bootable media.")
            sleep(0)
            monitor.setCursorPos(1,1)
            monitor.setBackgroundColor(colors.red)
            monitor.setTextColor(colors.white)
            monitor.write("The media inserted was invalid. Please insert a valid bootable media.                                               ")
            monitor.setCursorPos(1,2)
            monitor.setBackgroundColor(colors.black)
            monitor.setTextColor(colors.gray)
            monitor.setCursorPos(1,3)
            monitor.write("Here are some things you may want to try:")
            monitor.setCursorPos(1,5)
            monitor.write("* Checking your disk's root filename is 'startup.lua', 'main.lua' or 'bootloader.lua'.")
            
            monitor.setCursorPos(3,37)
            monitor.write("BIOS v4.1")
    end

else
    printError("(!) No bootable media was found. Please insert a valid bootable media.")
    sleep(0)
    monitor.setCursorPos(1,1)
    monitor.setBackgroundColor(colors.red)
    monitor.setTextColor(colors.white)
    monitor.write("No bootable media was found. Please insert a valid bootable media.                                               ")
    monitor.setCursorPos(1,2)
    monitor.setBackgroundColor(colors.black)
    monitor.setTextColor(colors.gray)
    monitor.setCursorPos(1,3)
    monitor.write("Here are some things you may want to try:")
    monitor.setCursorPos(1,5)
    monitor.write("* Inserting a floppy disk into the drive.")
            
    monitor.setCursorPos(3,37)
    monitor.write("BIOS" .. version .. "." .. subversion)
end
