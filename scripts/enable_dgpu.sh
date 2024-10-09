echo 1 > /sys/bus/pci/rescan

modprobe -f -a -v nvidia nvidia-modeset nvidia-drm nvidia-peermem nvidia-wmi-ec-backlight nvidia-uvm
