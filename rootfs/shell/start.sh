#!/bin/bash

#set -x

start=`date`
echo "Start: ${start}"
res1=$(date +%s.%N)

if [ -z "$JPEG_LEVEL" ]; then
  JPEG_LEVEL="m50"
fi

if [ -z "$NO_PNG_STRIP" ]; then
  PNG_STRIP_ALL="-strip all"
else
  PNG_STRIP_ALL=""
fi

# -mtime -7 \( '*.jpg' -o -name '*.png' \)
if [ -z "$DAYS_YOUNG" ]; then
  ADDFINDPART=""
else
  ADDFINDPART="-mtime -${DAYS_YOUNG} "
fi


echo "Optimizing .jpg, .jpeg (and .JPG, .JPEG) files .."
find /images/ $ADDFINDPART -name '*.jpg' -o -name '*.JPG' -o -name '*.jpeg' -o -name '*.JPEG' | xargs jpegoptim $JPEG_LEVEL

echo "Optimizing .png, .gif (and .PNG .GIF) files .."
find /images/ $ADDFINDPART -name '*.png' -o -name '*.PNG' -o -name '*.gif' -o -name '*.GIF' | xargs optipng -o2 $PNG_STRIP_ALL


end=`date`
echo "Finished: ${end}"

res2=$(date +%s.%N)
dt=$(echo "$res2 - $res1" | bc)
dd=$(echo "$dt/86400" | bc)
dt2=$(echo "$dt-86400*$dd" | bc)
dh=$(echo "$dt2/3600" | bc)
dt3=$(echo "$dt2-3600*$dh" | bc)
dm=$(echo "$dt3/60" | bc)
ds=$(echo "$dt3-60*$dm" | bc)

printf "Total runtime: %d:%02d:%02d:%02.4f\n" $dd $dh $dm $ds
