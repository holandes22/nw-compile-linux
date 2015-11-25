FROM holandes22/nw-compile-ubuntu-base

ADD app /tmp/Neverwinter/app

RUN mv -t /tmp/Neverwinter/nwn app/ambient app/data app/dmvault app/hak app/localvault app/modules app/movies app/music app/nwm app/texturepacks app/chitin.key app/dialog.tlk app/xp1.key app/xp2.key

RUN tar -xvzf nwclientgold.tar.gz -C nwn
RUN tar -xvzf nwclienthotu.tar.gz -C nwn
RUN tar -xvzf English_linuxclient169_xp2.tar.gz -C nwn

WORKDIR /tmp/Neverwinter/nwn

RUN apt-get install -y g++-multilib libelf-dev
RUN ./nwmouse_install.pl
RUN ./nwlogger.pl
RUN ./nwmovies_install.pl
RUN ./fixinstall
ADD nwn.sh /tmp/Neverwinter/nwn
ADD nwn.ini /tmp/Neverwinter/nwn
RUN chmod 777 /tmp/Neverwinter/nwn/nwn.sh
RUN cp /tmp/Neverwinter/app/nwncdkey.ini /tmp/Neverwinter/nwn
RUN chown -R root:root /tmp/Neverwinter/nwn
