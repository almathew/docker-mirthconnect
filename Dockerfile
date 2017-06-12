# See https://github.com/brandonstevens/mirth-connect-docker
FROM java

ENV MIRTHCONNECT_VERSION 3.5.0.8232.b2153

# Install NGiNX
RUN apt-get update && apt-get install nginx -y --no-install-recommends
RUN rm -f /etc/nginx/sites-enabled/default

# Install Mirth Connect
RUN \
  cd /tmp && \
  wget http://downloads.mirthcorp.com/connect/$MIRTHCONNECT_VERSION/mirthconnect-$MIRTHCONNECT_VERSION-unix.tar.gz && \
  tar xvzf mirthconnect-$MIRTHCONNECT_VERSION-unix.tar.gz && \
  rm -f mirthconnect-$MIRTHCONNECT_VERSION-unix.tar.gz && \
  mkdir -p /opt/mirthconnect && \
  mv Mirth\ Connect/* /opt/mirthconnect/ && \
  mkdir -p /opt/mirthconnect/appdata
WORKDIR /opt/mirthconnect

COPY templates/conf/mirth.properties /opt/mirthconnect/conf/mirth.properties

# NGiNX (X-Forwarded-Proto Proxy)
EXPOSE 3000

# Mirth (Direct)
EXPOSE 80 443

# 10 unmapped channels
EXPOSE 9661-9670

COPY templates/etc /etc
COPY templates/bin /usr/local/bin

CMD /usr/local/bin/mirthconnect-wrapper.sh
