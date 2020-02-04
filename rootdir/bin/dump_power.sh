#!/system/bin/sh

THERMAL_PATH="/sys/devices/virtual/thermal/"
if [ -d ${THERMAL_PATH} ]
then
    echo
    echo "---------------------------------"
    echo "Dump /sys/devices/virtual/thermal/"
    for d in `ls ${THERMAL_PATH}`
    do
        path=${THERMAL_PATH}/${d}
        thermal_type_file=${path}/type
        thermal_temp_file=${path}/temp
        if [ -f ${thermal_type_file} ]
        then
            if [ -f ${thermal_temp_file} ]
            then
                thermal_type=`cat ${thermal_type_file}`
                thermal_temp=`cat ${thermal_temp_file}`
                echo ""${thermal_type}":"${thermal_temp}""
            fi
        fi
    done
fi

#POWER_SUPPLY_DIR="/sys/class/power_supply"
#if [ -d ${POWER_SUPPLY_DIR} ]
#then
#    echo
#    echo "---------------------------------"
#    echo "Dump /sys/class/power_supply"
#    for d in `ls ${POWER_SUPPLY_DIR}`
#    do
#        path=${POWER_SUPPLY_DIR}/${d}
#        for f in `ls ${path}`
#        do
#            filename=${path}/${f}
#            if [ -f ${filename} ]
#            then
#                value=`cat ${filename}`
#                echo ""${filename}":"${value}""
#            fi
#        done
#    done
#fi

