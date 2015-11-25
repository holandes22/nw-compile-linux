#!/bin/bash

### Credit for this is to Pedro Mateus
### Extracted Verbatim from https://linuxgamecast.com/2015/11/l-g-c-how-to-installing-neverwinter-nights-linux-native/

#Standard stupid-proofing
cd "$(dirname "$0")"
#Thar be movies!!!!
export LD_PRELOAD=./nwmovies.so
#I’ll take some sound with that.
export LD_LIBRARY_PATH=./miles:$LD_LIBRARY_PATH
#run the game, allowing for executable flags
./nwmain $@
