# Cleeks

One app that I really missed from my Microsoft usin' days is TimeSnapper. TimeSnapper was a time-tracking application that took screenshots on a regular interval and let you add information about the work you were doing at the time. I only really ever cared about the screenshots and on more than one occasion being able to see what was on my screen several minutes ago was a major sanity saver.

Unfortunately there was no equivalent on OS X. :( So, I dug in and looked at what it would take to implement the basic functionality that I missed.

## How does it work?

OS X is incredibly easily scriptable as it turns out.

There's three parts to the Cleeks "app".

- just3ws.cleeks.plist.template

  This is the launchctl manifest that runs cleek.sh on a regular interval. I arbitrarily chose 32 seconds for my default interval.
- bin/install.sh

  This generates a plist from the template file then (re)installs just3ws.cleeks.plist
- bin/cleek.sh

  In a nutshell:
  - Creates a directory in at ~/Dropbox/Cleeks/hosts/CURRENT_HOST/CURRENT_USER
  - Takes a screenshot if the screensaver isn't running
  - Tidys up previous screenshots into directories grouped by day
  - Archives previous days of screenshots into zip files

## Installation

    cd ~/Dropbox
    git clone https://github.com/just3ws/Cleeks.git
    less bin/install.sh
    ./bin/install.sh # will require you to enter your sudo password

## License

Copyright (C) 2013 Michael D. Hall

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
