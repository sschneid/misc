#! /bin/bash
#
# fedora-ds-admin      Start/Stop the fedora DS admin daemon.
#
# chkconfig: - 99 01
# description: Manage stop/start for the Fedora Admin Server
# Source function library.
. /etc/init.d/functions

# Source our configuration file for these variables.
FLAGS=
RETVAL=0

# Set up some common variables before we launch into what might be
# considered boilerplate by now.
path_start=/opt/fedora-ds/start-admin
path_restart=/opt/fedora-ds/restart-admin
path_stop=/opt/fedora-ds/stop-admin
path=./ns-httpd
prog="Fedora-DS Admin"

start() {
	echo -n $"Starting $prog: "
	daemon $path_start 
	RETVAL=$?
	echo
	[ $RETVAL -eq 0 ] && touch /var/lock/subsys/$prog
	return $RETVAL
}

stop() {
	echo -n $"Stopping $prog: "
	$path_stop	
	RETVAL=$?
	echo
	[ $RETVAL -eq 0 ] && rm -f /var/lock/subsys/$prog
	return $RETVAL
}	
restart() {
        echo -n $"Restarting $prog: "
        daemon $path_restart
        RETVAL=$?
        echo
        [ $RETVAL -eq 0 ] && touch /var/lock/subsys/$prog
        return $RETVAL
}


case "$1" in
  start)
  	start
	;;
  stop)
  	stop
	;;
  restart)
  	restart
	;;
  status)
	status $path
	;;
  condrestart)
  	[ -f /var/lock/subsys/$prog ] && restart || :
	;;
  *)
	echo $"Usage: $0 {start|stop|status|reload|restart|condrestart}"
	exit 1
esac

exit $?
