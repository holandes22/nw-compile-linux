# What is this?

This is based on the post by Pedro Mateus at L.G.C. blog
https://linuxgamecast.com/2015/11/l-g-c-how-to-installing-neverwinter-nights-linux-native/
You should give it a read if you wanna know what this does.

All credit goes to him and the author of the compilation scripts https://github.com/nwnlinux. This is simply an automation of the steps in the post, using docker containers.

# TL:DR

You need (under any Linux distro):

- Docker and innoextract installed
- Download this repo/source code (e.g. from https://github.com/holandes22/nw-compile-linux/archive/master.zip) and extract wherever you want
- Download the NWN diamond files from GOG and place under the nw-linux-compile folder

Then run:

    $ cd nwn-linux-compile
    $ sh build

The game folder (compiled for Ubuntu) will be at nwn.


# Running the game (in an Ubuntu machine)

As of now, the compilation target runs only on Ubuntu machines. 
Once you have the folder produced by the build step (nwn), run from the terminal

    $ cd nwn
    $ ./nwn.sh # Taken from Pedro's post. I will run once to detect keys, next run will start the game

**Note** I needed to install one package to make in run in Ubuntu Mate 15.10

    $ sudo apt-get install libsdl1.2debian:i386

**Note** I only tested it runs with Ubuntu Mate 15.10

# Where it works

The build will run in any Linux where docker runs (basically everywhere).

The target (compiled game) will only work on Ubuntu and Ubuntu based distros (I used the official Ubuntu 14.04 docker image as base).

Work can be done to compile the game for other distros, so I'll try to get to that at
some point. Basically I need to build a base image for the main distros (Arch, Fedora, etc)

# It works with every NWN installer?

No idea, might be. I only used the NWN diamong installer from GOG because that is the one I own. You are free to try with others, but might require a changes in the script or the docker image. PR welcomed.

# Why Docker?

Compiling this game requires to install a lot of packages that I really didn't want to have in my
gaming rig. I try to keep it as lean as possible.

# Detailed steps to build

You need to provide the game files and placed them in a folder called app
I tested this with the installer from GOG and extracted it with innoextract under the
build folder:

    $ innoextract -e setup_nwn_diamond_*.exe

The build depends on an image called holandes22/nw-compile-ubuntu-base
This image contains all the pre-requisites to build NWN for Ubuntu.

If the image is not present locally, it will pull it from docker hub.
I built that image myself but you really should not trust it
and build it yourself with the included Dockerfile:

    $ docker build -t holandes22/nw-compile-ubuntu-base -f Dockerfile-ubuntu-base .

To compile the game:

    $ docker build -t nw-build .

Finaly, extract the folder with the compiled game from the container and copy it to the host

    $ image_id=$(docker create nw-build)
    $ docker cp $image_id:/tmp/Neverwinter/nwn .

# (Optional) Extracting the src with innoextract in a container

I tried to do also the extraction from bin files in the container to automate that step, but I run into problems with the container not caching the extract step thus causing every rebuild during dev to take forever.
I then decided to leave this step to the user.

The work I did on that, I placed it in another Dockerfile.
If you'd like to use it, place the installer files from GOG in the repo folder and run:

    $ docker build -t nw-extract-src -f Dockerfile-extract-src .
    $ image_id=$(docker create nw-extract-src)
    $ docker cp $image_id:/tmp/app .

The files will be place at ./app
