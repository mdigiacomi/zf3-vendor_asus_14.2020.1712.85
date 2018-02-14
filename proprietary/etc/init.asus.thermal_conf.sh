#!/system/bin/sh
# Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
#       copyright notice, this list of conditions and the following
#       disclaimer in the documentation and/or other materials provided
#       with the distribution.
#     * Neither the name of The Linux Foundation nor the names of its
#       contributors may be used to endorse or promote products derived
#       from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
# ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#

# No path is set up at this point so we have to do it here.
PATH=/sbin:/system/sbin:/system/bin:/system/xbin
export PATH

#ASUS_BSP +++ Show_Cai create symbolic link to vadc                         
FILES=`ls /sys/devices/soc/`                                          
search_vadc=qpnp-vadc                                                   
bFound=0                                                                
for name in $FILES                                                      
do                                                                      
        search_vadc_temp=${name:0:${#search_vadc}}                      
        if [ "$search_vadc"x = "${search_vadc_temp}"x ]; then                    
                        SUB_FILE=`ls /sys/devices/soc/$name`          
                        search_die=die_temp_asus                             
                        search_pmi8952_mpp1=pmi8952_mpp1_temp           
                        for sub_name in $SUB_FILE                       
                        do                                              
                                if [ "$sub_name" = "$search_die" ]; then
                                        bFound=`expr "$bFound" + "1"`   
                                        die_path=$name                  
                                fi                                      
                                if [ "$sub_name" = "$search_pmi8952_mpp1" ]; then
                                        bFound=`expr "$bFound" + "1"`            
                                        pmi8952_mpp1_path=$name                  
                                fi                                               
                                if [ "$bFound" == "2" ]; then                    
                                        break                                    
                                fi                                               
                        done                                                     
        fi                                                                       
                                                                                 
        if [ "$bFound" == "2" ]; then                                                                   
                break                                                            
        fi                                                                       
done                                                                             

if [ "$bFound" == "2" ]; then                                                    
        mkdir -p /dev/therm/                                                     
        chmod 755 /dev/therm/                                                    
        mkdir -p /dev/therm/vadc                                                 
        chmod 755 /dev/therm/vadc                                                
        ln -s /sys/devices/soc/$die_path/die_temp_asus /dev/therm/vadc/die_therm    
        ln -s /sys/devices/soc/$pmi8952_mpp1_path/pmi8952_mpp1_temp /dev/therm/vadc/pmi8952_mpp1_temp
fi                      

ln -s /sys/class/thermal/thermal_zone2/mtemp /dev/therm/vadc/msm_therm                                                                             
#ASUS_BSP --- Show_Cai create symbolic link to vadc  

#start thermal-engine

#ASUS_BSP +++ Show_Cai create symbolic link for run-in test
ln -s /sys/class/thermal/thermal_zone7/mtemp /data/data/Thermal0
ln -s /sys/class/thermal/thermal_zone8/mtemp /data/data/Thermal1
ln -s /sys/class/thermal/thermal_zone9/mtemp /data/data/Thermal2
ln -s /sys/class/thermal/thermal_zone10/mtemp /data/data/Thermal3
ln -s /sys/class/thermal/thermal_zone15/mtemp /data/data/Thermal4
ln -s /sys/class/thermal/thermal_zone20/mtemp /data/data/Thermal5
ln -s /sys/class/thermal/thermal_zone22/mtemp /data/data/Thermal6
ln -s /sys/class/thermal/thermal_zone23/mtemp /data/data/Thermal7
ln -s /sys/class/thermal/thermal_zone1/mtemp /data/data/Thermal8
ln -s /sys/class/thermal/thermal_zone2/mtemp /data/data/Thermal9
ln -s /sys/class/thermal/thermal_zone4/mtemp /data/data/Thermal10
ln -s /dev/therm/vadc/die_therm /data/data/Thermal11
ln -s /dev/therm/vadc/pmi8952_mpp1_temp /data/data/Thermal12
ln -s /sys/class/power_supply/battery/device/PRT8301_temp /data/data/Thermal13

sleep 10
echo 14 > /data/data/ThermalCount
chmod 664 /data/data/ThermalCount
#ASUS_BSP --- Show_Cai creat symbolic link for run-in test
