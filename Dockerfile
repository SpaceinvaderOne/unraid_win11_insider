FROM ubuntu:18.04
MAINTAINER SpaceinvaderOne
RUN apt-get update && apt-get -y install git wget rsync aptitude sudo curl software-properties-common build-essential apt-utils aria2 cabextract wimtools chntpw genisoimage
COPY . /win11
VOLUME /isos
VOLUME /config
CMD chmod 777 ./win11/unraid.sh && bash ./win11/unraid.sh ; sleep 5