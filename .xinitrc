#!/bin/sh

exec dbus-launch i3
exec picom --config ~/.config/picom/picom.conf
