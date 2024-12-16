modprobe -r -f -v --remove-holders nvidia-modeset

echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove
