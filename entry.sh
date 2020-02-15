#!/bin/bash

# First we need to start cups
echo "Start Cups"
    /usr/sbin/cupsd -f &
# Remove AVAHI Services
echo "Start Avahi"
    /usr/sbin/avahi-daemon &


