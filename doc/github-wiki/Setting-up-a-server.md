1. [Setting up a server](#setting-up-a-server)
	1. [Running a dedicated server](#running-a-dedicated-server)
		1. [Linux](#linux)
		2. [Windows](#windows)

# Setting up a server

1. Start your server on your desired port
	* **Note**: It is recommended to leave the port at the default (30000)
2. Find out your internal IP of the computer you are running the server on
	* **Linux**: open a terminal and type ifconfig and hit enter
	* **Windows**: _Start -> Run … -> cmd.exe -> ipconfig_
3. Check the port forwarding settings on your router
	* forward your chosen port for UDP (30000 if you left it default) to the internal IP
	* In addition, alter any firewalls you may have to pass the traffic at that port
4. Let your friends know your external IP
5. Make your server listed in the server list by setting the following settings in stonecraft.conf
	* server_announce = true - makes Stonecraft tell the server list about the server.
	* server_name - set the value of this to your server's name.
	* server_description - set the value of this to a longer description describing your server.
	* server_address - if you have a domain name for your server, then set this to the domain name.
	* server_url - if you have a website for your server, then set this to the website URL.
	* motd - a message that is sent to the player when they join. Use this to welcome them.
	* You should restart the server to make sure any changed settings changed

## Running a dedicated server

### Linux

1. Open a terminal.
2. Type in _&lt;YOUR/STONECRAFT/DIRECTORY&gt;/bin/stonecraftserver_ or just drop the stonecraftserver executable (located in _/Stonecraft/bin/_) into the terminal **(PLEASE READ THE NOTES BELOW!)**
	* If you want to specify a specific game ID, the game ID choices are located in _/Stonecraft/games/_. Add in _--gameid thegameid_ to the end of the command.
	* If you get the error "Multiple worlds are available.", the world choices are located in _/Stonecraft/worlds/_. Add in _--worldname theWorld_ to the end of the command.
3. If your server crashes, then look at the debug.txt in _/Stonecraft/bin/_
4. Enjoy running a Stonecraft server!

For easy use you can create a file named _start-stonecraft.sh_, add the lines below and put it in your _/Stonecraft/bin/_ folder.

```
#!/bin/bash -e

until ./stonecraftserver --worldname ../worlds/<YOUR-WORLD>; do
    echo "Server 'stonecraftserver' crashed with exit code $?. Respawning.." >&2
    sleep 1
done
```

You have to make the script executable with the command

```
chmod +x start-stonecraft.sh
```

To run the server, just execute the script in a terminal with

```
./start-stonecraft.sh
```

Tipp: Add the start script to your /etc/rc.local file to run Stonecraft automatically if your system is rebooting.

```
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

<YOUR/STONECRAFT/DIRECTORY>/bin/start-stonecraft.sh

exit 0
```

### Windows

1. Open command prompt by going in the _/Stonecraft/bin/_ folder, hold Shift, do a right click on _bin_ and click "Open command window here".
2. Type this: _stonecraft.exe --server_.
	* If you get the error "Multiple worlds are available.", use _stonecraft.exe --server --worldname world_name_ instead, where world_name is the name of the world.
3. If your server crashes, then look at the debug.txt in _/Stonecraft/bin/_
4. Enjoy running a Stonecraft server!

If you don't like to start the crashed server, simply start the server out of a batch file which contains the following code:

```
@echo off
:crash
stonecraft.exe --server --worldname world_name
goto crash
```
