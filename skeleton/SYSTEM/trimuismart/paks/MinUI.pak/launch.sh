#!/bin/sh
# MiniUI.pak

# leds off
echo 0 > /sys/devices/platform/sunxi-led/leds/led1/brightness
echo 0 > /sys/devices/platform/sunxi-led/leds/led2/brightness
echo 0 > /sys/devices/platform/sunxi-led/leds/led3/brightness

# recover from readonly SD card -------------------------------
touch /mnt/writetest
sync
if [ -f /mnt/writetest ] ; then
	rm -f /mnt/writetest
else
	e2fsck -p /dev/root > /mnt/SDCARD/RootRecovery.txt
	reboot
fi

#######################################

export PLATFORM="trimuismart"
export ARCH_TAG=arm-480
export SDCARD_PATH="/mnt/SDCARD"
export BIOS_PATH="$SDCARD_PATH/Bios"
export SAVES_PATH="$SDCARD_PATH/Saves"
export SYSTEM_PATH="$SDCARD_PATH/.system/$PLATFORM"
export CORES_PATH="$SYSTEM_PATH/cores"
export USERDATA_PATH="$SDCARD_PATH/.userdata/$PLATFORM"
export LOGS_PATH="$USERDATA_PATH/logs"
export DATETIME_PATH=$USERDATA_PATH/.minui/datetime.txt # used by bin/shutdown
export ARCH_PATH="$SDCARD_PATH/.userdata/$ARCH_TAG"

mkdir -p "$USERDATA_PATH"
mkdir -p "$LOGS_PATH"
mkdir -p "$ARCH_PATH/.minui"

#######################################

# TODO: overclock

echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo A,B,X,Y,L,R > /sys/module/gpio_keys_polled/parameters/button_config

#######################################

export LD_LIBRARY_PATH=$SYSTEM_PATH/lib:/usr/trimui/lib:$LD_LIBRARY_PATH
export PATH=$SYSTEM_PATH/bin:/usr/trimui/bin:$PATH
env

# TODO:
# keymon.elf &

#######################################

AUTO_PATH=$USERDATA_PATH/auto.sh
if [ -f "$AUTO_PATH" ]; then
	"$AUTO_PATH"
fi

cd $(dirname "$0")

#######################################

EXEC_PATH=/tmp/minui_exec
NEXT_PATH="/tmp/next"
touch "$EXEC_PATH"  && sync
while [ -f "$EXEC_PATH" ]; do
	# overclock.elf $CPU_SPEED_PERF
	minui.elf &> $LOGS_PATH/minui.txt
	sync
	
	if [ -f $NEXT_PATH ]; then
		CMD=`cat $NEXT_PATH`
		eval $CMD
		rm -f $NEXT_PATH
		# if [ -f "/tmp/using-swap" ]; then
		# 	swapoff $USERDATA_PATH/swapfile
		# 	rm -f "/tmp/using-swap"
		# fi
		# overclock.elf $CPU_SPEED_PERF
		sync
	fi
done

poweroff # just in case
