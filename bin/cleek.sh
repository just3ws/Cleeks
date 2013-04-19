#!/bin/bash -e

function is_screensaver_running () {
  osascript -e 'tell application "System Events"'         \
            -e 'get running of screen saver preferences'  \
            -e 'end tell'
}

cd "$HOME/Dropbox/Cleeks/hosts/`hostname -s`/`whoami`"

now=`date "+%Y-%m-%d-%H-%M-%S"`
today=`echo $now | cut -d'-' -f1-3`

if [[ "false" == "`is_screensaver_running`" ]]; then
  screencapture -C -x -t jpg $now.jpg
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
    rm -rf $directory
  fi
done

cd -
