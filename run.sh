#!/bin/sh
wget -O ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
unzip ngrok.zip
{
    mkfifo pipe
    echo "Executing nc"
    nc -l -v 8888 <pipe | bash >pipe
    killall -SIGINT ngrok && echo "ngrok terminated"
} &
{
    echo "Executing ngrok"
    ./ngrok authtoken $NGROK_TOKEN
    ./ngrok tcp 8888 --log=stdout --log-level=debug
} &
sleep 10m
