#!/bin/bash

ps auxw | grep voicemail.asterisk_mailbox.daemon | grep -v grep > /dev/null

if [ $? -ne 0 ]; then
    /sbin/service service-voicemail-monitor restart > /dev/null 2>&1
    exit
else
    svc_pid=$(pidof -s /srv/service-voicemail/bin/python -m voicemail.asterisk_mailbox_daemon)
    threadct=$(ps hH p $svc_pid | wc -l)
    if [ $threadct -lt 5 ]; then
        /sbin/service service-voicemail-monitor restart > /dev/null 2>&1
    fi
    exit
fi
