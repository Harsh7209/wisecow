#!/bin/bash

cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print int(100-$8)}')
mem=$(free | awk '/Mem:/ {print int($3/$2*100)}')
disk=$(df / | awk 'NR==2 {gsub("%","",$5); print $5}')

echo "------ $(date) ------"

if [ $cpu -gt 80 ]
then
    echo "CPU usage is high: ${cpu}%"
fi

if [ $mem -gt 80 ]
then
    echo "Memory usage is high: ${mem}%"
fi

if [ $disk -gt 80 ]
then
    echo "Disk usage is high: ${disk}%"
fi

echo "Running processes: $(ps -ef | wc -l)"