#! /usr/bin/env sh

export FILENAME="/tmp/paging-$RANDOM.txt"

cat /dev/stdin > $FILENAME

nvim -c "term cat $FILENAME"

rm $FILENAME
