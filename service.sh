#!system/bin/sh
MODDIR=${0%/*}

# Execute script by tytydraco and his project ktweak, thanks! 
write() {
	# Bail out if file does not exist
	[[ ! -f "$1" ]] && return 1
	
	# Make file writable in case it is not already
	chmod +w "$1" 2> /dev/null

	# Write the new value and bail if there's an error
	if ! echo "$2" > "$1" 2> /dev/null
	then
		echo "Failed: $1 → $2"
		return 1
	fi
}

sleep 30

#Gracias a Crok (https://github.com/crok/crokrammgmtfix)
[ $(getprop ro.build.version.release) -gt 9 ] && cmd device_config set_sync_disabled_for_tests persistent
[ $(getprop ro.build.version.release) -gt 9 ] && cmd device_config put activity_manager max_cached_processes 10 || settings put global activity_manager_constants max_cached_processes=10

#Para no matar de apps en específico
#para agregar mas apps agregue el nombre de paquete separado con una coma (,) ejemplo: com.whatsapp,com.xvideos.app,com.copy&paste.developer
[ $(getprop ro.build.version.release) -gt 9 ] && cmd device_config put activity_manager imperceptible_kill_exempt_packages com.whatsapp

exit 0