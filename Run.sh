#!/bin/bash

log=/home/art/logs/Run-ART-based-on-load.log
[[ ! -f $log ]] && { mkdir -p $(dirname $log) ; touch $log ; }

preset_maximum_load=2

#抓取系统1分钟平均负载
average=$(cat /proc/loadavg | awk '{print $1}')


#当前负载小于2时，运行ART，否则不运行
if [ $(echo "$average < $preset_maximum_load" |bc) -eq 1 ]; then
    echo -e "$(date "+%Y.%m.%d %H:%M:%S") System load: $average" >> $log
    echo "The ART was executed successfully" >> $log
    /usr/local/bin/autoremove-torrents --conf=/home/art/config.yml --log=/home/art/logs
else
    echo -e "$(date "+%Y.%m.%d %H:%M:%S") System load: $average" >> $log
    echo "The ART was not executed because the current load is greater than the preset." >> $log
fi
