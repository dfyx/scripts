#!/bin/bash

# This script was tested on:
#  - Ubuntu
#  - Debian
#  - Gentoo
#  - Redhat
#  - OpenWRT
#  - Mac OS X 10.6
#  - cygwin
#  - Git bash for Windows (mingw32)
# It should also work on most other unixes

# Determine the sed parameter for extended regular expressions
echo x | sed -r 's/x/x/' 2> /dev/null > /dev/null
SED_EXIT_CODE=$?

if [ "${SED_EXIT_CODE}" -eq 0 ]; then
	SED_EXTREG='-r'		# GNU sed
else
	SED_EXTREG='-E'		# BSD sed
fi

# Determine distribution
if [ -f /etc/lsb[_-]release ]; then	# Ubunutu and maybe others
	DISTRIBUTION=$(grep 'DISTRIB_ID=' /etc/lsb-release | head -n 1 | sed 's/DISTRIB_ID=//')
elif [ $(ls /etc/*[-_]release 2>/dev/null | wc -l) -ne 0 ]; then		# Most other linuxes
	DISTRIBUTION=$(ls -1 /etc/*[-_]release 2>/dev/null | head -n 1 | sed $SED_EXTREG 's/^\/etc\/(.*)[-_]release$/\1/')
elif [ $(ls /etc/*[-_]version 2>/dev/null | wc -l) -ne 0 ]; then		# Most other linuxes
	DISTRIBUTION=$(ls -1 /etc/*[-_]version 2>/dev/null | head -n 1 | sed $SED_EXTREG 's/^\/etc\/(.*)[-_]version$/\1/')
elif uname -a | grep -i cygwin > /dev/null; then	# cygwin
	DISTRIBUTION=cygwin
elif uname -a | grep -i mingw32_nt > /dev/null; then
	DISTRIBUTION=mingw32
elif which sw_vers 2>/dev/null > /dev/null; then	# Mac OS X and maybe others
	DISTRIBUTION=$(sw_vers | grep ProductName | head -n 1 | sed $SED_EXTREG 's/^ProductName:[ \t]*//' | sed 's/ //g')
fi

# Make sure it's all lower case
DISTRIBUTION=$(echo $DISTRIBUTION | awk '{print tolower($0)}')

if [ -z "$DISTRIBUTION" ]; then
	echo 'Unknown distribution' >&2
	exit 1
fi
echo $DISTRIBUTION
