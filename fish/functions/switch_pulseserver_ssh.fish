#!/usr/bin/fish

function switch_pulseserver_ssh --description "switch between local and ssh pulse server"
	[ x"$PULSE_SERVER" = x ] ; and set -gx PULSE_SERVER localhost:40000 ; and echo PULSE_SERVER=localhost:40000 ; and return 0
	[ x"$PULSE_SERVER" = x ] ; or set -ex PULSE_SERVER ; and echo PULSE_SERVER unset ; and return 0

end
