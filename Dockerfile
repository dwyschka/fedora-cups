FROM fedora:31
MAINTAINER "Daniel Wyschka" <d.wyschka@sensou.de>
ENV container docker
RUN yum install -y redhat-rpm-config gcc unzip cups avahi avahi-tools python2 wget; \
    yum install -y cups-libs.i686 libstdc++ libstdc++.i686 cups-libs cups-libs.i686 python2-devel cups-devel; \
    yum clean all; 
RUN sed -i 's/localhost\:631/0.0.0.0\:631/g' /etc/cups/cupsd.conf;
RUN cd /tmp; \
    curl http://download.support.xerox.com/pub/drivers/6000/drivers/linux/en_GB/6000_6010_rpm_1.01_20110222.zip --output driver.zip; \
    unzip driver.zip; \
    cd rpm_1.01_20110222; \
    rpm -i Xerox-Phaser_6000_6010-1.0-1.i686.rpm;

RUN cd /tmp; \
    pip2 install pycups; \
    mv /usr/bin/python2 /usr/bin/python; \
    wget -O /usr/local/bin/airprint-generate.py --no-check-certificate https://raw.github.com/jpawlowski/airprint-generate/master/airprint-generate.py; \
    wget -O /usr/local/bin/avahisearch.py --no-check-certificate https://raw.github.com/jpawlowski/airprint-generate/master/avahisearch.py; \
    chmod 755 /usr/local/bin/airprint-generate.py /usr/local/bin/avahisearch.py; 

COPY ./entry.sh /usr/entry.sh
RUN chmod +x /usr/entry.sh 
USER root

ENTRYPOINT [ "/usr/entry.sh" ]
