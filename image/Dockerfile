FROM stepsaway/baseimage:##TAG##
MAINTAINER StepsAway <devgru@stepsaway.com>

COPY . /fr_build
RUN /fr_build/install.sh

EXPOSE \
    1812/udp \
    1813 \
    18120

CMD ["/sbin/my_init"]
