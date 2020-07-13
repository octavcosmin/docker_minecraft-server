FROM alpine
CMD /bin/bash
LABEL maintainer="Macovei Octavian-Cosmin"

EXPOSE 25565 25575

COPY mcserver mcserver-completion.bash /root/docker-data/
VOLUME /data /backups

RUN \
 echo "~~~install packages~~~" &&\
 apk add --update --no-cache openjdk11 screen bash &&\
\
 echo "~~~cleanup~~~" &&\
 rm -v -rf /var/cache.apk/* &&\
\
 echo "~~~make adjustments~~~" &&\
 chmod +x /root/docker-data/mcserver &&\
 echo "PATH=$PATH:/root/docker-data" >> ~/.bashrc &&\
 echo "source /root/docker-data/mcserver-completion.bash" >> ~/.bashrc


