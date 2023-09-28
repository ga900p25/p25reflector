#!/bin/bash
### P25Reflector-Installation-Script
#
# This script installs a P25Reflector on a Debian-like Linux-System
# with modification of P25Reflector.ini and creation of all necessary
# scripts to start and run the P25Reflector. It is based on the YSFReflector install.sh by g6nhu. Free to use without warranty. 
#  Changelog:
# 2023-09-23: initial shot
# 2023-09-25: revisions by w4noc to convert to p25reflector with dvswitch-server directory structure and improvements.
# 2023-09-28: revisions by w4noc to comments. Example P25Reflector.ini provided. 
###
echo Checking prerequisites
ERROR=0
dpkg -s git &> /dev/null
if [ $? -eq 0 ]; then
    echo "Package git is installed!"
else
    echo "Package git is NOT installed!"
    ERROR=1
fi
dpkg -s build-essential &> /dev/null
if [ $? -eq 0 ]; then
    echo "Package build-essential is installed!"
else
    echo "Package build-essential is NOT installed!"
    ERROR=1
fi
if [ $ERROR == 1 ]; then
    echo "Please install missing packages!"
    exit 1
fi
echo Cloning repository from github
git clone https://github.com/nostar/DVReflectors.git
echo
echo compiling
cd DVReflectors/P25Reflector/
make clean all
echo
echo Copying ini-file
sudo cp P25Reflector.ini /opt/P25Reflector/P25Reflector.ini
echo
echo Name of Reflector - 16 characters maximum length:
read -r name
sudo sed -i -e "s/16 characters max/${name}/g" /opt/P25Reflector/P25Reflector.ini
echo Description of Reflector - 14 characters maxmimum length:
read -r description
sudo sed -i -e "s/14 characters max/${description}/g" /opt/P25Reflector/P25Reflector.ini
sudo groupadd mmdvm
sudo useradd mmdvm -g mmdvm -s /sbin/nologin
sudo cp P25Reflector /usr/local/bin/P25Reflector
# the next two lines may fail if dvswitch-server is already installed since the path exists
sudo mkdir /var/log/mmdvm
sudo chown mmdvm /var/log/mmdvm
sudo sed -i -e "s/FilePath=./FilePath=\/var\/log\/P25Reflector/g" /opt/P25Reflector/P25Reflector.ini
cat > P25Reflector.sh << EOF
#!/bin/bash
### BEGIN INIT INFO
#
# Provides:             P25Reflector
# Required-Start:       \$all
# Required-Stop:        
# Default-Start:        2 3 4 5
# Default-Stop:         0 1 6
# Short-Description:    Example startscript P25Reflector

#
### END INIT INFO
## Fill in name of program here.
PROG="P25Reflector"
PROG_PATH="/usr/local/bin/"
PROG_ARGS="/opt/P25Reflector/P25Reflector.ini"
PIDFILE="/var/run/P25Reflector.pid"
USER="root"

start() {
      if [ -e \$PIDFILE ]; then
          ## Program is running, exit with error.
          echo "Error! \$PROG is currently running!" 1>&2
          exit 1
      else
          cd \$PROG_PATH
          ./\$PROG \$PROG_ARGS
          echo "\$PROG started"
          touch \$PIDFILE
      fi
}

stop() {
      if [ -e \$PIDFILE ]; then
          ## Program is running, so stop it
         echo "\$PROG is running"
         rm -f \$PIDFILE
         killall \$PROG
         echo "\$PROG stopped"
      else
          ## Program is not running, exit with error.
          echo "Error! \$PROG not started!" 1>&2
          exit 1
      fi
}

## Check to see if we are running as root first.
## Found at
## http://www.cyberciti.biz/tips/shell-root-user-check-script.html
if [ "\$(id -u)" != "0" ]; then
      echo "This script must be run as root" 1>&2
      exit 1
fi

case "\$1" in
      start)
          start
          exit 0
      ;;
      stop)
          stop
          exit 0
      ;;
      reload|restart|force-reload)
          stop
          sleep 5
          start
          exit 0
      ;;
      **)
          echo "Usage: \$0 {start|stop|reload}" 1>&2
          exit 1
      ;;
esac
exit 0
### END
EOF
sudo cp P25Reflector.sh /etc/init.d/P25Reflector.sh
sudo chmod +x /etc/init.d/P25Reflector.sh
# issue with insserve is unresolved 25Sep2023
sudo insserv P25Reflector.sh
echo
echo "Edit /opt/P25Reflector.ini see example in this repository. Then you may start your P25Reflector with" 
echo "sudo /etc/init.d/P25Reflector.sh start"
