#!/bin/bash
# 
# gen.sh -- generate photos.json from images in current directory.
#
# Usage: ./gen.sh
#
# Will overwrite photos.json without warning.
#
# Currently only images named *.jpg are supported.
#

if ! which exiv2 2>&1 >/dev/null
then
	echo 'Please install exiv2 before proceeding.'
	exit
fi

TARGET=./photos.json

echo -n > $TARGET

function output {
	echo $@ >> $TARGET
}

output '['

first=1
photos=0

for x in *.jpg
do
#	exiv2 -pt $x
	if (( $photos ))
	then
		output ","
	fi

	output -en '\t{ file: "'$x'" }'

#	if (( $first ))
#		then echo
#		else echo ','
#	fi
	
	photos=$(($photos + 1))
done

output -e '\n]'

echo Generated photos.json with $photos photos.
