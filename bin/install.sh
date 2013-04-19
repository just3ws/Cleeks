#!/bin/bash

rm -f just3ws.cleek.plist
sed "s/USER_HOME/\/Users\/`whoami`/g" just3ws.cleek.plist.template > just3ws.cleek.plist
mv -f $HOME/Dropbox/Cleeks/just3ws.cleek.plist ~/Library/LaunchAgents

sudo chown root ~/Library/LaunchAgents/just3ws.cleek.plist
sudo chmod 644 ~/Library/LaunchAgents/just3ws.cleek.plist

sudo launchctl unload ~/Library/LaunchAgents/just3ws.cleek.plist
sudo launchctl load ~/Library/LaunchAgents/just3ws.cleek.plist

mkdir -p "$HOME/Dropbox/Cleeks/hosts/`hostname -s`/`whoami`"
