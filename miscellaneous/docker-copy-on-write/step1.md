
Create a directory "cow-test"

`mkdir cow-test`{{execute}}

`cd cow-test`{{execute}}

Creating two Dockerfiles - Dockerfile.base and Dockerfile
Using the first one to create an image called acme/my-base-image:1.0

`touch Dockerfile.base`{{execute}}


The second one is based on acme/my-base-image:1.0, but has some additional layers:

`touch Dockerfile`{{execute}}


`touch hello.sh`{{execute}}


Open and copy below content to Dockerfile.base

`/root/cow-test/Dockerfile.base`{{open}}

<pre class="file"
 data-filename="/root/cow-test/Dockerfile.base"
  data-target="replace">
FROM ubuntu:18.04
COPY . /app
</pre>

Open and copy below content to Dockerfile

`/root/cow-test/Dockerfile`{{open}}

<pre class="file"
 data-filename="/root/cow-test/Dockerfile"
  data-target="replace">
FROM acme/my-base-image:1.0
CMD /app/hello.sh
</pre>


Open and copy below content to hello.sh 

`/root/cow-test/hello.sh`{{open}}

<pre class="file"
 data-filename="/root/cow-test/hello.sh"
  data-target="replace">
#!/bin/sh
echo "Hello world"
</pre>

Save the file, and make it executable:

`chmod +x hello.sh`{{execute}}


Build the image from first Dockerfile.base

`docker build -t acme/my-base-image:1.0 -f Dockerfile.base .`{{execute}}


Build the second image from Dockerfile.

`docker build -t acme/my-final-image:1.0 -f Dockerfile .`{{execute}}


Check out the sizes of the images:

`docker image ls`{{execute}}


Check out the layers that comprise each image:

`docker history acme/my-base-image:1.0`{{execute}}


`docker history acme/my-final-image:1.0`{{execute}}


Notice that all the layers are identical except the top layer of the second image. 
All the other layers are shared between the two images, and are only stored once in /var/lib/docker/. 
The new layer actually doesn’t take any room at all, because it is not changing any files, but only running a command.





