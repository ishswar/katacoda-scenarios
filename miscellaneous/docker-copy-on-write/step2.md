Image and container layers on-disk

THE IMAGE LAYER 

`ls -l /var/lib/docker/overlay/`{{execute}}

Warning: Do not directly manipulate any files or directories within /var/lib/docker/. These files and directories are managed by Docker.


THE CONTAINER LAYER


`docker run -itd ubuntu sleep 3600`{{execute}}

Containers also exist on-disk in the Docker host’s filesystem under /var/lib/docker/overlay/. If you list a running container’s subdirectory using the ls -l command, three directories and one file exist:

<pre class="file">

$ ls -l /var/lib/docker/overlay/<directory-of-running-container>

total 16
-rw-r--r-- 1 root root   64 Jun 20 16:39 lower-id
drwxr-xr-x 1 root root 4096 Jun 20 16:39 merged
drwxr-xr-x 4 root root 4096 Jun 20 16:39 upper
drwx------ 3 root root 4096 Jun 20 16:39 work
</pre>

The lower-id file contains the ID of the top layer of the image the container is based on, which is the OverlayFS lowerdir.

The upper directory contains the contents of the container’s read-write layer, which corresponds to the OverlayFS upperdir.

The merged directory is the union mount of the lowerdir and upperdir, which comprises the view of the filesystem from within the running container.

The work directory is internal to OverlayFS.

To view the mounts which exist when you use the overlay storage driver with Docker, use the mount command. The output below is truncated for readability.

`mount | grep overlay`{{execute}}

