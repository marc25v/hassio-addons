# Docker file to create an image for a hass.io add-on that contains enough software to listen to events via RTL_SDR/HoneyWellSecurity
# Events are published  to an MQTT broker.
# The script resides in a volume and can be modified to meet your needs.

# This hass.io addon is based on James Fry project here https://github.com/james-fry/hassio-addons/rtl2mqtt
# which is based on Chris Kacerguis' project here: https://github.com/chriskacerguis/honeywell2mqtt,
# which is in turn based on Marco Verleun's rtl2mqtt image here: https://github.com/roflmao/rtl2mqtt

# IMPORTANT: The container needs privileged access to /dev/bus/usb on the host.

ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

MAINTAINER Saad Syed

LABEL Description="This image is used to start a script that will monitor for RF events on 345Mhz for Honeywell 5800 series sensors and send the data to an MQTT server"

#
# First install software packages needed to compile rtl_sdr, Honeywell security and to publish MQTT events.
#

RUN apk add --no-cache --virtual build-deps alpine-sdk cmake git libusb-dev && \
    mkdir /tmp/src && \
    cd /tmp/src && \
    git clone git://git.osmocom.org/rtl-sdr.git && \
    mkdir /tmp/src/rtl-sdr/build && \
    cd /tmp/src/rtl-sdr/build && \
    cmake ../ -DINSTALL_UDEV_RULES=ON -DDETACH_KERNEL_DRIVER=ON -DCMAKE_INSTALL_PREFIX:PATH=/usr/local && \
    make && \
    make install && \
    chmod +s /usr/local/bin/rtl_* && \
    cd /tmp/src/ && \
    git clone https://github.com/marc25v/HoneywellSecurity.git && \
    cd HoneywellSecurity/rpi && \
    chmod +x ./build.sh && \
    ./build.sh && \
    cp honeywell /usr/local/bin && \
    cd /tmp && \
    apk del build-deps && \
    rm -r /tmp/src && \
    apk add --no-cache libusb mosquitto-clients jq alpine-sdk

#
# Define an environment variable
#
# Use this variable when creating a container to specify the MQTT broker host.
#

ENV MQTT_HOST="192.168.0.35"
ENV MQTT_USER="mqtt-alarm"
ENV MQTT_PASS="guest"
ENV MQTT_TOPIC="ha/sensor/alarm"

CMD cd / && cp /config/honeywell2mqtt/honeywell2mqtt.sh /honeywell2mqtt.sh && chmod +x /honeywell2mqtt.sh && /honeywell2mqtt.sh
