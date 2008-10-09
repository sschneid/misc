#! /bin/bash
#
# Fedora-ds    start and stop a Fedora DS
#
# chkconfig: - 98 02
# Source function library.
. /etc/init.d/functions

# Source our configuration file for these variables.
FLAGS=
RETVAL=0
ulimit -n 8192
# Set up some common variables before we launch into what might be
# considered boilerplate by now.
path_start=/opt/fedora-ds/slapd-ldap1/start-slapd
path_restart=/opt/fedora-ds/slapd-ldap1/restart-slapd
path_stop=/opt/fedora-ds/slapd-ldap1/stop-slapd

path=./ns-slapd
prog="Fedora-DS Ldap1"

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
