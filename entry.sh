#!/bin/bash

# First we need to start cups
echo "Start Cups"
    exec nohup /usr/sbin/cupsd -f &
# Remove AVAHI Services
echo "Remove Services.."
    rm -rf /etc/avahi/services/*
echo "Regenerate Airprint Services.." 
    exec python /usr/local/bin/airprint-generate.py --cups -d /etc/avahi/services;




