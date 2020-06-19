# Minecraft Server in Docker
## Description
This is a simple docker container based on [Alpine](https://hub.docker.com/_/alpine), meant to run your Minecraft server. 

## Versions
**Use the version tag instead of "latest" because I don't know how to auto generate "latest".**
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
 - start: A simple(ish) script for starting the server. It has support for screen with the `-s` argument. **The default value for "screen" is false, not true as written in the help and I'm too lazy to fix it in this version**
 

## Run the container

 This is the suggested script for running the container. **Use the version tag instead of "latest" because I don't know how to auto generate "latest".**
 

    docker run -d \
	--name minecraft-server \
    -p <server-port>:25565 \
    -p <console-port>:25575 \
	-v <path-to-shared-folder>:<shared-folder> \
	octavcosmin/minecraft-server:v1

|Option|Details  |
|--|--|
| \<server-port\> | The port that the server will run on, and will need to be forwarded in the router settings for access from outside the local network. |
| \<console-port\> | \*LINE IS OPTIONAL\* The RCON port. |
| \<path-to-shared-folder\> | \*LINE IS OPTIONAL BUT RECOMMENDED\* The path to the local folder which will be accessible from inside the container. It is the easiest way to import backups. |
| \<shared-folder\> | The path to the mount point of the shared folder inside the container.  |

**\*There is currently no Dockerfile for manual building**
## Beginner Guide
This is a guide meant to help docker beginners setup their container.

 1. Copy the code in the **Run the Container** in a text editor.
 2. Replace the text inside "<...>" and remove the `-p <console-port>:25575 \` line if you don't need it.
	 Example code:
	 
        docker run -d \
	    --name minecraft-server \
	    -p 25565:25565 \
		-v /home/$USER/shared-folder:/shared \
		octavcosmin/minecraft-server:v1
	**If you get a `Permission dennied` error write `sudo` before `docker run...` and fill in your password if prompted.**
 3. Paste/Write it in the terminal or SSH client's terminal.
 4. Access the container using `sudo docker attach <name (minecraft-server in the example)>` 
 5. Download the wanted server version with the `mcserver get <url>`, where '\<url\>' is the download link. I recommend using mcversions.net. Access the site, click 'Download' on the wanted version, then right click on 'Download Server Jar' and copy the address ('Copy link address' for Chrome). Paste it instead of '\<url\>'.
 6. \*OPTIONAL\* If you want to import any data from a previous version, Detach from the container **without stopping it using `Ctrl+p,Ctrl+q `**, paste the server's folder in the /home/$USER/shared-folder, then attach to the container again and use `mcserver import /shared` to import the data. 
 7. To start the server run `mcserver start` the default allocated memory is 1GB, which should be enough for a small server with 3-4 players. For further information use `mcserver start --help`.
 8. Forward the port before ":" in the router's settings. (`host-port:container-port`).
