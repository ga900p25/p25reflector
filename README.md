# p25reflector 'install.sh' - Creates a P25Reflector on an x86 PC under DEBIAN 10.  
27 September 2023
Free to use or distribute. It is offered without warranty. Use at your own risk. 
This simple script install.sh will retrieve the DVReflectors including P25Reflector, compile and install on an x86 PC running DEBIAN 10.
It is a derivative work based on the g6nhu YSFReflector install.sh.  This script has been tested once on a x86-64 with DEBIAN10, ASL2.0.0-6B, and DVSwitch-server.  It should work under DEBIAN 11.  Preconfigured packges are readily available for ARM/Pi.  But no longer around for x86 PC. 
I created it for myself.  You are welcome to use it edit it as you see fit.  Do edit the /opt/mmdvm/P25Reflector.ini per the example below. In particular; Daemon, Name, FilePath, Port.
If you are not running dvswitch-server you may need a method to update the DMRids.dat file.
https://database.radioid.net/static/user.csv
