#!/bin/sh

mkdir /byond
chown $RUNAS:$RUNAS /byond /bs12 europa.rsc

gosu $RUNAS DreamDaemon europa.dmb 8000 -trusted -verbose
