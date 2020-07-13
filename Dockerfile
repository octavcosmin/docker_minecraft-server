FROM alpine
CMD /bin/bash
LABEL version="v1.3.1" \
    schema-version="1.0" \
    maintainer="Macovei Octavian-Cosmin" \
    name="Minecraft Server" \
    description="Docker container based on Alpine, made for running a Minecraft server" \
    url="https://github.com/octavcosmin/docker_minecraft-server" \
    vcs-url="https://github.com/alpinelinux/docker-alpine" \
    docker.cmd="docker run -d -it \
--name minecraft-server \
-p <server-port>:25565 \
-p <console-port>:25575 \
-v <path-to-data-folder>:/data \
-v <path-to-backups-folder>:/backups \
octavcosmin/minecraft-server"

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


