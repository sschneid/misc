#!/bin/bash
# cosign        Init script for running the cosign daemon
#
# Author:       Scott Schneider <sschneid@gmail.com>
#
# chkconfig: - 98 02
#
# description: Enables enterprise single sign-on authentication via cosign
# processname: cosignd monsterd
# config: /etc/cosign/cosign.conf

PATH=/usr/bin:/sbin:/bin:/usr/sbin
export PATH

lockfilec=${LOCKFILE-/var/lock/subsys/cosign}
lockfilem=${LOCKFILE-/var/lock/subsys/monster}
cosignd=${COSIGND-/usr/sbin/cosignd}
monsterd=${MONSTERD-/usr/sbin/monster}
RETVAL=0

# Source function library
. /etc/rc.d/init.d/functions

startcosign() {
    echo -n $"Starting cosign: "
        daemon $cosignd
    RETVAL=$?
    echo
        [ $RETVAL = 0 ] && touch ${lockfilec}
        return $RETVAL
}

startmonster() {
    echo -n $"Starting monster: "
        daemon $monsterd
    RETVAL=$?
    echo
        [ $RETVAL = 0 ] && touch ${lockfilem}
        return $RETVAL

}

restartcosign() {
    echo -n $"Restarting cosign: "
        killproc $cosignd -HUP
    RETVAL=$?
    echo
    return $RETVAL
}

restartmonster() {
    echo -n $"Restarting monster: "
        killproc $monsterd -HUP
    RETVAL=$?
    echo
    return $RETVAL
}

stopcosign() {
    echo -n $"Stopping cosign: "
        killproc $cosignd
    RETVAL=$?
    echo
    [ $RETVAL = 0 ] && rm -f ${lockfilec}
}

stopmonster() {
    echo -n $"Stopping monster: "
        killproc $monsterd
    RETVAL=$?
    echo
    [ $RETVAL = 0 ] && rm -f ${lockfilem}
}


start() {
    startcosign
    startmonster
}

restart() {
    restartcosign
    restartmonster
}

stop() {
    stopcosign
    stopmonster
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
    *)
        echo $"Usage: $0 {start|stop|restarat}"
        exit 1
esac

exit $RETVAL

