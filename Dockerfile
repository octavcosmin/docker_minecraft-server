FROM alpine
CMD ["/bin/ash"]

COPY mcserver /bin/

RUN \
 echo "~~~install packages~~~" &&\
 apk add --update openjdk11 screen &&\
\
 echo "~~~cleanup~~~" &&\
 rm -v -rf /var/cache.apk/*

EXPOSE 25565 25575
VOLUME /data /backups
