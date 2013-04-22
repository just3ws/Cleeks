#!/bin/bash -e

function is_screensaver_running () {
  osascript -e 'tell application "System Events"'         \
            -e 'get running of screen saver preferences'  \
            -e 'end tell'
}

mkdir -p "$HOME/Dropbox/Cleeks/hosts/`hostname -s`/`whoami`"
cd "$HOME/Dropbox/Cleeks/hosts/`hostname -s`/`whoami`"

now=`date "+%Y-%m-%d-%H-%M-%S"`
today=`echo $now | cut -d'-' -f1-3`

if [[ "false" == "`is_screensaver_running`" ]]; then
  if [[ ! -a ~/Pause-Cleeks ]]; then
    screencapture -C -x -t jpg $now.jpg
    RESULT=$?
    if [ $RESULT -eq 0 ]; then
      echo "screencapture succeeded: $now" >> ~/just3ws-cleeks.log
    else
      echo "screencapture failed: $now" >> ~/just3ws-cleeks.log
    fi
  fi
fi

IFS=$'\n'

for file in `find . -name "*.jpg" -depth 1`; do
  directory="$(echo $file | cut -d'-' -f1-3)"
  mkdir -p "$directory"
  mv "$file" "$directory"
done

for directory in `ls -l | grep '^d' | awk '{ print $9 }'`; do
  if [[ "$directory" != $today ]]; then
    zip -rm -9 -v -j -T -q $directory $directory/*.jpg
    RESULT=$?
    if [ $RESULT -eq 0 ]; then
      echo "zip archiving succeeded: $directory" >> ~/just3ws-cleeks.log
    else
      echo "zip archiving failed: $directory" >> ~/just3ws-cleeks.log
    fi
    rm -rf $directory
  fi
done

echo "" >> ~/just3ws-cleeks.log
cd -
