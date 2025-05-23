for artist in *
do
	cd $artist
	for album in *
	do
		cd $album

		for song in *.mp3
		do
			id3v2 -t $song -a $artist -A $album -T $(echo $song | cut -d\- -f1)/$(ls -1 | grep -c .\*) $song
		done
		cd ..
	done
	cd ..
done
