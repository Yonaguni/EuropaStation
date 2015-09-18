#!/bin/bash

for i in {1..3}
do
	MAPFILE="box-$i.dmm"
	git show HEAD:maps/$MAPFILE > tmp.dmm
	java -jar MapPatcher.jar -clean tmp.dmm '../../maps/'$MAPFILE '../../maps/'$MAPFILE
	rm tmp.dmm

        MAPFILE="europa-$i.dmm"
        git show HEAD:maps/$MAPFILE > tmp.dmm
        java -jar MapPatcher.jar -clean tmp.dmm '../../maps/'$MAPFILE '../../maps/'$MAPFILE
        rm tmp.dmm

done
