export FSR=$(fzf)
if [ $FSR ]
then
	$@
else
	exec $SHELL
fi
