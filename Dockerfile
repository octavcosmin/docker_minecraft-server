FROM alpine
CMD ["/bin/bash"]

COPY mcserver /bin/

EXPOSE 25565 25575
VOLUME /data /backups

RUN \
 echo "~~~install packages~~~" &&\
 apk add --update --no-cache openjdk11 screen bash &&\
\
 echo "~~~cleanup~~~" &&\
 rm -v -rf /var/cache.apk/* &&\
\
 echo "~~~make adjustments~~~" &&\
 chmod +x /bin/mcserver
