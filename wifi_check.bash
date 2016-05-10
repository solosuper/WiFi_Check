#!/usr/bin/env bash

# The IP for the server to ping
SERVER=10.0.1.1

INTERFACE="wlan0"

LOCKFILE="/var/run/$(basename $0).pid"

logger -t $0 "$(date) routine check for $INTERFACE"

### Handle lockfile ###
if [ -e ${LOCKFILE} ]; then
  PID=$(<${LOCKFILE})
  if kill -0 &>1 > /dev/null $PID; then
    logger -t $0 "$PID still running"
    exit 1
  else
    rm ${LOCKFILE}
  fi
fi

echo $$ > ${LOCKFILE}

### Check status by ping
ping -c2 ${SERVER} > /dev/null
if [ $? != 0 ]; then
  logger -t $0 "ping ${SERVER} failed - run ifup on ${INTERFACE}"
  ifdown --force ${INTERFACE}
  sleep 5
  ifup ${INTERFACE}
fi

### Check status by ifconfig
# if ifconfig $wlan | grep -q "inet addr:" ; then
#     # Network is Okay
# else
#   logger -t $0 "ping ${SERVER} failed - run ifup on ${INTERFACE}"
#   ifdown --force ${INTERFACE}
#   sleep 5
#   ifup ${INTERFACE}
# fi

### Exit
rm ${LOCKFILE}
exit 0

# end

