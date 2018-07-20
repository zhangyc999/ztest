#!/usr/bin/bash

input=$1
id=$2

cat $input                                                                                             \
| grep "$id" -n                                                                                        \
| awk '{if(strtonum("0x"$8$7)>32767){print strtonum("0x"$8$7)-65536} else {print strtonum("0x"$8$7)}}' \
> /tmp/posi.txt

cat $input                                                                                                \
| grep "$id" -n                                                                                           \
| awk '{if(strtonum("0x"$10$9)>32767){print strtonum("0x"$10$9)-65536} else {print strtonum("0x"$10$9)}}' \
> /tmp/vel.txt

cat $input                                                                                                   \
| grep "$id" -n                                                                                              \
| awk '{if(strtonum("0x"$12$11)>32767){print strtonum("0x"$12$11)-65536} else {print strtonum("0x"$12$11)}}' \
> /tmp/ampr.txt

if [ $# -eq 2 ];then
gnuplot --persist << EOF
set title "$id"
set multiplot
set grid
plot "/tmp/posi.txt" w l title "POSI", "/tmp/vel.txt" w l title "VEL", "/tmp/ampr.txt" w l title "AMPR"
EOF
fi

