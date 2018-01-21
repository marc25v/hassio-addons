# Honeywell to MQTT Bridge hass.io addon
A hass.io addon for a software defined radio (SDR) tuned to listen for 345MHz RF transmissions and republish the data via MQTT.
It is designed for Honeywell 58xx Door/Window and PIR sensors, and will not work with any other type of sensors.

The addon will compile the necessary dependencies on build.

This hass.io addon is based on James Fry's project here https://github.com/james-fry/hassio-addons/rtl2mqtt
which is based on Chris Kacerguis' project here: https://github.com/chriskacerguis/honeywell2mqtt,
which is in turn based on Marco Verleun's rtl2mqtt image here: https://github.com/roflmao/rtl2mqtt

Instead of previous projects, it leverages Justin Haines's HoneywellSecurity project from here  https://github.com/jhaines0/HoneywellSecurity forked to publish to MQTT.

HoneywellSecurity is much simpler than the more powerful rtl_433 by Steve Markgraf from https://github.com/merbanan/rtl_433.

## Usage

1) Install the addon.

2) [Not Implemented] Use addon configuration to configure: (Uses below hard coded values)
- mqtt_host = 172.30.32.1
- mqtt_user = null
- mqtt_password = null
- mqtt_topic = 'homeassistant/sensor/honeywell'

3) Copy honeywell2mqtt.sh to your hass.io config dir in a subdir called honeywell2mqtt.
i.e. .../config/honeywell2mqtt/honeywell2mqtt.sh
This allows you to edit the start script if you need to make any changes

4) Start the addon

## MQTT Data

This addon has been tested with Honeywell 5816 wireless door/window sensors and PIR sensors.

Data to the MQTT server will look like the following:

#### PIR Sensor:

```
MQTT Topic: homeassistant/sensor/honeywell/<serialid>
```
```json
{
  "serial": <serialid>,
  "isMotion": true,
  "tamper": false,
  "alarm": false,
  "batteryLow": false,
  "heartbeat": false,
  "lastUpdateTime": "Sat Jan 20 15:17:51 2018 PST",
  "lastAlarmTime": "Sat Jan 20 15:16:55 2018 PST"
}
```

#### Door/Window Sensor

```
MQTT Topic: homeassistant/sensor/honeywell/<serialid>
```
```json
{
  "serial": <serialid>,
  "isMotion": false,
  "tamper": false,
  "alarm": true,
  "batteryLow": false,
  "heartbeat": false,
  "lastUpdateTime": "Sat Jan 20 21:32:24 2018 PST",
  "lastAlarmTime": "Sat Jan 20 21:32:24 2018 PST"
}
```
## Hardware

This has been tested and used with the following hardware (you can get it on Amazon)

- Honeywell 5816 Wireless Door/Windows Transmitter
- Honeywell 5800PIR-RES
- NooElec NESDR Nano 2+ Tiny Black RTL-SDR USB
- NooElec NESDR SMArt - Premium RTL-SDR w/ Aluminum Enclosure 


## Troubleshooting

If you see this error:

> Kernel driver is active, or device is claimed by second instance of librtlsdr.
> In the first case, please either detach or blacklist the kernel module
> (dvb_usb_rtl28xxu), or enable automatic detaching at compile time.

Then run the following command on the host

```bash
sudo rmmod dvb_usb_rtl28xxu rtl2832
```

## Note

