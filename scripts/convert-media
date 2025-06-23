#! /bin/sh

for i in *.$1
do
	ffmpeg -i "$i" "${i%.*}.$2" &
done

for i in  *.$2
do
	id3v2 -t $i $i
done
