#!/bin/sh
XVFB=/usr/bin/Xvfb
XVFBARGS=":1 -ac -screen 0 1024x768x16"
PIDFILE=/tmp/xvfb-pid-1

case "$1" in
  start)
    echo -n "Starting virtual X frame buffer: Xvfb"
    /sbin/start-stop-daemon --start --pidfile $PIDFILE --make-pidfile --background --exec $XVFB -- $XVFBARGS
    echo "."
    ;;
  stop)
    echo -n "Stopping virtual X frame buffer: Xvfb"
    /sbin/start-stop-daemon --stop --pidfile $PIDFILE
    rm -f $PIDFILE
    echo "."
    ;;
  status)
    if [ -f $PIDFILE ] && [ -d /proc/$(cat $PIDFILE) ]; then
      echo "Xvfb running."
      exit 0
    else
      echo "Xvfb not running."
      exit 4
    fi
    ;;
  restart)
    $0 stop
    $0 start
    ;;
  *)
    echo "Usage: /etc/init.d/xvfb {start|stop|restart|status}"
    exit 1
esac

exit 0
