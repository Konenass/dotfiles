#!/bin/bash
# Script to start apps who needs to be kill on reload

APPS=(
)

KILL=(
)

# Kill lingering apps
for app in "${APPS[@]}"
do
    kill -9 $(pidof $app)
done
for app in "${KILL[@]}"
do
    kill -9 $(pidof $app)
done

# Start new instance
for app in "${APPS[@]}"
do
    env $app ${@:2} &
done
