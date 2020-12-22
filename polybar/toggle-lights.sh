#! /bin/bash

brightness="240"
r="255"
g="255"
b="255"
effect="none"
ip="192.168.0.2"
entityName="light/leds_habitacion"

getState() {
	curl -s -X GET "http://$1/$2" | jq ".state"
}

turnOn(){
	dir="http://$1/$2/turn_on?brightness=$3&r=$4&g=$5&b=$6&effect=$7"
	echo $dir
	curl -X POST $dir
}

setBrightnessDown(){
	brightness=$(( ${brightness}-10 ))
	if [ $brightness -lq 100 ] 
	then
		brightness=100
	fi
	turnOn "$ip" "$entityName" "$brightness" "$r" "$g" "$b" "$effect"
}

setBrightnessUp(){
	brightness=$(( ${brightness}+10 ))
	if [ $brightness -gt 255 ]
	then
		$brightness=255
	fi
	turnOn "$ip" "$entityName" "$brightness" "$r" "$g" "$b" "$effect"
}

toggleLights() {
state=$(getState $ip $entityName)
if [ $state = "\"ON\"" ]
then
       	turnOn "$ip" "$entityName" "0" "$r" "$g" "$b" "$effect"
	echo "turnOff!"
else
	turnOn "$ip" "$entityName" "$brightness" "$r" "$g" "$b" "$effect"
	echo "turnOn!"
fi
}


brightness="240"
r="255"
g="255"
b="255"
effect="none"
ip="192.168.0.2"
entityName="light/leds_habitacion"

trap toggleLights USR1
#trap setBrightnessDown TERM
#trap setBrightnessUp INT

while true; do
	state=$(getState $ip $entityName)
	brightness=$(curl -s -X GET "http://$ip/$entityName") | jq ".brightness"
	if [ $state = "\"ON\"" ]
	then
		echo " ON"
	else
		echo " OFF"
	fi
	sleep 2 &
	wait
done
