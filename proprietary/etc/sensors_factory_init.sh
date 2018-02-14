#!/system/bin/sh

PROXM_SPEC_FILE="/data/data/proximity_spec"
LIGHT_SPEC_FILE="/data/data/lightsensor_spec"
PROXM_INF_FILE="/factory/psensor_inf.nv"
PROXM_HI_FILE="/factory/psensor_hi.nv"
PROXM_LOWI_FILE="/factory/psensor_low.nv"
LIGHT_200_FILE="/factory/lsensor_200lux.nv"
LIGHT_1000_FILE="/factory/lsensor_1000lux.nv"
GSENSOR_X_FILE="/factory/gsensor_x.nv"
GSENSOR_Y_FILE="/factory/gsensor_y.nv"
GSENSOR_Z_FILE="/factory/gsensor_z.nv"

sensor_chmod()
{
	if [ -f $1 ];
	then
		echo "File $FILE exists"
		chmod 660 $1
		chown system:shell $1
	else
		echo "File $FILE does not exists"
		echo 0 > $1
		chmod 660 $1
		chown system:shell $1
	fi
}

sensor_chmod $PROXM_SPEC_FILE
sensor_chmod $LIGHT_SPEC_FILE

sensor_chmod $PROXM_INF_FILE
sensor_chmod $PROXM_HI_FILE
sensor_chmod $PROXM_LOWI_FILE
sensor_chmod $LIGHT_200_FILE
sensor_chmod $LIGHT_1000_FILE

sensor_chmod $GSENSOR_X_FILE
sensor_chmod $GSENSOR_Y_FILE
sensor_chmod $GSENSOR_Z_FILE

exit 0
