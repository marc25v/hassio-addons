#!/bin/sh

# A simple script that will receive events from an RTL433 SDR and resend the data via MQTT

# Author: Chris Kacerguis <chriskacerguis@gmail.com>
# Modification for hass.io add-on: James Fry
# Motification for replacing with honeywellsecurity: Saad Syed

# Everything is hard coded inside the honeywell app right now, options.json do not work.

export LANG=C
PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"

CONFIG_PATH=/data/options.json
MQTT_HOST="$(jq --raw-output '.mqtt_host' $CONFIG_PATH)"
MQTT_USER="$(jq --raw-output '.mqtt_user' $CONFIG_PATH)"
MQTT_PASS="$(jq --raw-output '.mqtt_password' $CONFIG_PATH)"
MQTT_TOPIC="$(jq --raw-output '.mqtt_topic' $CONFIG_PATH)"
PROTOCOL="$(jq --raw-output '.protocol' $CONFIG_PATH)"

# Start the listener and enter an endless loop
echo "Starting RTL_433 with parameters:"
echo "MQTT Host =" $MQTT_HOST
echo "MQTT User =" $MQTT_USER
echo "MQTT Password =" $MQTT_PASS
echo "MQTT Topic =" $MQTT_TOPIC
echo "RTL_433 Protocol =" $PROTOCOL

#set -x  ## uncomment for MQTT logging...

/usr/local/bin/honeywell | while read line
