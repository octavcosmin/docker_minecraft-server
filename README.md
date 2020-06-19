---


---

<h1 id="minecraft-server-in-docker">Minecraft Server in Docker</h1>
<h2 id="description">Description</h2>
<p>This is a simple docker container based on <a href="https://hub.docker.com/_/alpine">Alpine</a>, meant to run your Minecraft server.</p>
<h2 id="versions">Versions</h2>
<p><strong>Use the version tag instead of “latest” because I don’t know how to auto generate “latest”.</strong></p>
<ul>
<li>v1</li>
</ul>
<h2 id="the-mcserver-command">The <code>mcserver</code> command</h2>
<p>This container has a built-in command meant to make using the image easy for beginners.<br>
Use <code>mcserver --help</code> for further details or read the short documentation bellow.</p>
<h4 id="subcommands">Subcommands</h4>
<p>The command mentioned above is based on unprofessionally written subcommands that still work somehow (hopefully). <em>Further instructions in the ‘Beginner Guide’ section.</em>  Run <code>mcserver &lt;subcommand&gt; --help</code> for more information about the command structure and arguments. This is a full list of the included subcommands:</p>
<ul>
<li>backup: Backups the important server files in the default folder <code>/home/backups</code> or in a folder specified by the user.</li>
<li>get: Downloads the <code>mcserver.jar</code> file from the link introduced by the user. It is mostly just beginner-friendly front for <code>wget</code>.<br>
<strong>WARNING: make sure to rename the server executable to <code>server.jar</code>.</strong></li>
<li>import: Imports the necessary server files from a folder specified by the user.</li>
<li>start: A simple(ish) script for starting the server. It has support for screen with the <code>-s</code> argument. <strong>The default value for “screen” is false, not true as written in the help and I’m too lazy to fix it in this version</strong></li>
</ul>
<h2 id="run-the-container">Run the container</h2>
<p>This is the suggested script for running the container. <strong>Use the version tag instead of “latest” because I don’t know how to auto generate “latest”.</strong></p>
<pre><code>docker run -d \
--name minecraft-server \
-p &lt;server-port&gt;:25565 \
-p &lt;console-port&gt;:25575 \
-v &lt;path-to-data-folder&gt;:/data \
-v &lt;path-to-backups-folder&gt;:/backups \
octavcosmin/minecraft-server:v1
</code></pre>

<table>
<thead>
<tr>
<th>Option</th>
<th>Details</th>
</tr>
</thead>
<tbody>
<tr>
<td>&lt;server-port&gt;</td>
<td>The port that the server will run on, and will need to be forwarded in the router settings for access from outside the local network.</td>
</tr>
<tr>
<td>&lt;console-port&gt;</td>
<td>*OPTIONAL* The RCON port.</td>
</tr>
<tr>
<td>&lt;path-to-data-folder&gt;</td>
<td>*OPTIONAL BUT RECOMMENDED* Host path where <code>/data</code> will be mounted.</td>
</tr>
<tr>
<td>&lt;path-to-backups-folder&gt;</td>
<td>*OPTIONAL BUT RECOMMENDED* Host path where <code>/backups</code> will be mounted.</td>
</tr>
<tr>
<td>&lt;shared-folder&gt;</td>
<td>The path to the mount point of the shared folder inside the container.</td>
</tr>
</tbody>
</table><p><strong>*There is currently no Dockerfile for manual building</strong></p>
<h2 id="beginner-guide">Beginner Guide</h2>
<p>This is a guide meant to help docker beginners setup their container.</p>
<ol>
<li>
<p>Copy the code in the <strong>Run the Container</strong> in a text editor.</p>
</li>
<li>
<p>Replace the text inside “&lt;…&gt;” and remove the <code>-p &lt;console-port&gt;:25575 \</code> line if you don’t need it.<br>
Example code:</p>
<pre><code>docker run -d \
--name minecraft-server \
-p 25565:25565 \
-v /home/$USER/data:/data \
-v /home/$USER/backups:/backups \
octavcosmin/minecraft-server:v1
</code></pre>
<p><strong>If you get a <code>Permission dennied</code> error write <code>sudo</code> before <code>docker run...</code> and fill in your password if prompted.</strong></p>
</li>
<li>
<p>Paste/Write it in the terminal or SSH client’s terminal.</p>
</li>
<li>
<p>Access the container using <code>sudo docker attach &lt;name (minecraft-server in the example)&gt;</code></p>
</li>
<li>
<p>Download the wanted server version with the <code>mcserver get &lt;url&gt;</code>, where ‘&lt;url&gt;’ is the download link. I recommend using <a href="http://mcversions.net">mcversions.net</a>. Access the site, click ‘Download’ on the wanted version, then right click on ‘Download Server Jar’ and copy the address (‘Copy link address’ for Chrome). Paste it instead of ‘&lt;url&gt;’.</p>
</li>
<li>
<p>To start the server run <code>mcserver start</code> the default allocated memory is 1GB, which should be enough for a small server with 3-4 players. For further information use <code>mcserver start --help</code>.</p>
</li>
<li>
<p>Forward the port before “:” in the router’s settings. (<code>host-port:container-port</code>).</p>
</li>
</ol>
<h4 id="importing-backups">Importing Backups</h4>
<p>If you want to import a previous backup run <code>mcserver import /backups/&lt;folder&gt;</code>.</p>

