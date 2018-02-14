#!/system/bin/sh
instantCamera_enable=`getprop persist.asus.instant_camera`
if [ "$instantCamera_enable" == "1" ]; then
	echo "114" > /sys/devices/soc/soc:gpio_keys/enabled_wakeup
	echo "115" > /sys/devices/soc/soc:gpio_keys/enabled_wakeup
elif [ "$instantCamera_enable" == "0" ]; then
	echo "114" > /sys/devices/soc/soc:gpio_keys/disabled_wakeup
	echo "115" > /sys/devices/soc/soc:gpio_keys/disabled_wakeup

elif [ "$instantCamera_enable" == "" ]; then
	echo "114" > /sys/devices/soc/soc:gpio_keys/disabled_wakeup
        echo "115" > /sys/devices/soc/soc:gpio_keys/disabled_wakeup
else
	exit 0
fi
