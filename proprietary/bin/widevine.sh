#!/system/bin/sh

/system/bin/is_keybox_valid

# start install_key_server
setprop "atd.start.key.install" 1      
