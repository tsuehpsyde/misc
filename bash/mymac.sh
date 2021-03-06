#!/bin/bash
# Script to find your public MAC address.
# v1.1 - Made it a little better.
# v1.0 - Initial script
# 
# Copyright (C) 2008  James Bair <james.d.bair@gmail.com>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software Foundation,
# Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

# PATH information
PATH="/bin:/sbin:$PATH"

# Make sure our apps are installed.
nscheck=$(netstat --help > /dev/null 2>&1 ; echo $?)
ifcheck=$(ifconfig --help > /dev/null 2>&1 ; echo $?)
if [ "$nscheck" -eq 127 ]; then
	echo 'We cannot find netstat on your system.'
	echo 'Exiting'
	exit 1
elif [ "$ifcheck" -eq 127 ]; then
	echo 'We cannot find ifconfig on your system.'
	echo 'Exiting.'
	exit 1
fi

# Find public interface, then MAC address.
interface=$(netstat -rn |  awk '($1 ~ /0.0.0.0/) {print $8}')
mac=$(ifconfig $interface | grep $interface | awk '{print $5}')

if [ -n "$mac" ]; then
	echo "$mac"
	exit 0
else
	echo 'Oops! Public MAC address not found!'
	echo 'Exiting.'
	exit 1
fi
