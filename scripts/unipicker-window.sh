#! /bin/sh
# while true
# do

# 	if [ -z $(UNIPICKER_SYMBOLS_FILE=/home/redstonetrail/projects/unipicker/symbols UNIPICKER_COPY_COMMAND=/bin/wl-copy unipicker --copy) ]
# 	then
# 		break
# 	else
# 		echo a
# 	fi
# done

UNIPICKER_SYMBOLS_FILE=/home/redstonetrail/projects/unipicker/symbols UNIPICKER_COPY_COMMAND=/bin/wl-copy unipicker > /tmp/unipicker-out.txt
cat /tmp/unipicker-out.txt | wl-copy
