
# Minecraft Server in Docker
## Description
This is a simple docker container based on [Alpine](https://hub.docker.com/_/alpine), meant to run your Minecraft server. 

## Versions
 - latest (default)
 - v1.1
 - v1

## The `mcserver` command
This container has a built-in command meant to make using the image easy for beginners.
Use `mcserver --help` for further details or read the short documentation bellow.

#### Subcommands
The command mentioned above is based on unprofessionally written subcommands that still work somehow (hopefully). *Further instructions in the 'Beginner Guide' section.*  Run `mcserver <subcommand> --help` for more information about the command structure and arguments. This is a full list of the included subcommands:

 - backup: Backups the important server files in the default folder `/home/backups` or in a folder specified by the user.
 - get: Downloads the `mcserver.jar` file from the link introduced by the user. It is mostly just beginner-friendly front for `wget`. 
 **WARNING: make sure to rename the server executable to `server.jar`.**
 - import: Imports the necessary server files from a folder specified by the user.
 - start: A simple(ish) script for starting the server. It has support for screen with the `-s` argument.
 

## Run the container

 This is the suggested script for running the container.
 

    docker run -d -it \
	--name minecraft-server \
    -p <server-port>:25565 \
    -p <console-port>:25575 \
	-v <path-to-data-folder>:/data \
	-v <path-to-backups-folder>:/backups \
	octavcosmin/minecraft-server

|Option|Details  |
|--|--|
| \<server-port\> | The port that the server will run on, and will need to be forwarded in the router settings for access from outside the local network. |
| \<console-port\> | \*OPTIONAL\* The RCON port. |
| \<path-to-data-folder\> | \*OPTIONAL BUT RECOMMENDED\* Host path where `/data` will be mounted.|
| \<path-to-backups-folder\> | \*OPTIONAL BUT RECOMMENDED\* Host path where `/backups` will be mounted.|
| \<shared-folder\> | The path to the mount point of the shared folder inside the container.  |

## Build Locally
All files available in the [GitHub repository](https://github.com/octavcosmin/docker_minecraft-server).

    git https://github.com/octavcosmin/docker_minecraft-server.git
    cd docker_minecraft-server
    docker build \
        --no-cache \
        --pull \
        -t octavcosmin/minecraft-server:latest .


## Beginner's Guide
This is a guide meant to help docker beginners setup their container.

 1. Copy the code in the **Run the Container** section in a text editor.
 2. Replace the text inside "<...>" and remove the `-p <console-port>:25575 \` line if you don't need it.
	 Example code:
	 
        docker run -d -it\
	    --name minecraft-server \
	    -p 25565:25565 \
		-v /home/$USER/data:/data \
		-v /home/$USER/backups:/backups \
		octavcosmin/minecraft-server
	**If you get a `Permission dennied` error write `sudo` before `docker run...` and fill in your password if prompted.**
 3. Paste/Write it in the terminal or SSH client's terminal.
 4. Access the container using `sudo docker attach <name (minecraft-server in the example)>` 
 5. Download the wanted server version with the `mcserver get <url>`, where '\<url\>' is the download link. I recommend using mcversions.net. Access the site, click 'Download' on the wanted version, then right click on 'Download Server Jar' and copy the address ('Copy link address' for Chrome). Paste it instead of '\<url\>'.
 6. To start the server run `mcserver start` the default allocated memory is 1GB, which should be enough for a small server with 3-4 players. For further information use `mcserver start --help`.
 7. Forward the port before ":" in the router's settings. (`host-port:container-port`).

#### Importing Backups
If you want to import a previous backup run `mcserver import /backups/<folder>`.

## Change Log
 - v1.1
 > - Version "latest" is being auto-built from the [GitHub repository](https://github.com/octavcosmin/docker_minecraft-server).
 > - Created a Dockerfile for manual builds.
 > - Changed the the help from the `-s|--screen` from `(default: true)` to `(default: false)` to better reflect the default value. (aka I messed up in v1).
 > Updated the README
 - v1: **First version**

