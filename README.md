# p25reflector 'install.sh' - Creates a P25Reflector on an x86 PC under DEBIAN 10 and Rpi under DEBIAN 12 Bookworm (Dec 10 2024).  
27 September 2023
Free to use or distribute. It is offered without warranty. Use at your own risk. 
This simple script install.sh will retrieve the DVReflectors including P25Reflector, compile and install on an x86 PC running DEBIAN 10.
It is a derivative work based on the g6nhu YSFReflector install.sh.  This script has been tested once on a x86-64 with DEBIAN10, ASL2.0.0-6B, and DVSwitch-server.  It should work under DEBIAN 11.  Preconfigured packges are readily available for ARM/Pi.  But no longer around for x86 PC. 
I created it for myself.  You are welcome to use it edit it as you see fit.  Do edit the /opt/mmdvm/P25Reflector.ini per the example below. In particular; Daemon, Name, FilePath, Port.
If you are not running dvswitch-server you may need a method to update the DMRids.dat file.
https://database.radioid.net/static/user.csv

6 April 2024
The P25Reflector.ini is not copying to /opt/P25Reflector.  I'll work on the bug in the install.sh and try to figure out why this is happening.  In the meanwhile, you can create /opt/P25Reflector then copy the sample P25Reflector.ini provided here to that path before launching the install.sh. Let me know how that works out for you.  
31 July 2024 'install.sh' revised.
Improved messaging to the user following the test to verify the packages build-essential and git are installed.  The script will fail if these two prerequisite packages are not installed.  You can check to see if the packages are installed before running install.sh using these two simple commands: dpkg -s git and dpkg -s build-essential.  Save yourself some time and install these packages if not already present.  Consult the web for package installation instructions.  

10Aug 2024 - install.sh revised.
Improved messsaging. Removed unnecessary code.  User must edit /opt/P25Gateway.ini and be certain /var/lib/mmdvm/DMRIds.dat is present.  It will run without DVSwitch-server present.  But you will need to retrieve your own DMRIDs.dat.  Following these edits, it will compile under DEBIAN12/bookworm on a Rpi4.  build-essentials will likely be present. You will need to load git. Please also note that the DEBIAN12 firewall may be blocking UDP41000.  If P25Gateways cannot connect, check your firewall and open the UDP port selected in P25Reflector.ini.   

10 Dec 2024 - 'install.sh' tested successfully on an IONOS VPS under DEBIAN 12 loaded from ISO.  If using systemd, add your own systemd unit file. As of this date, the P25Reflector Dashboard will not operate under DEBIAN 12 and PHP 8.2.26.  The lighttpd error.log would fill under PHP 7, but the P25Reflector Dashboard is unusable under PHP8.     
