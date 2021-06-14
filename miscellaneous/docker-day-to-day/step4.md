
# Troubleshooting - know your way around  

Invariably you will be required to troubleshoot issue with docker image or container - let do little bit of that  

### Inspect the image 

Read image metadata 

`docker inspect my-py-flask:1.0.0`{{execute}}

This should give us lot of key information about image without actually running it 

1. When image was `created` 
1. What `command` it will run when it starts
1. What `ports` we need to expose when we run this image 
1. What is size of image 
1. What OS `user` will be use to run image 
1. What the OS Level `environment` variables 
1. What are the `labels` that identifies this image 
1. Where on disk this image is stored 
1. and much more ... 

### log-in (exec) in to Running container 

Run command inside container without logging in 

`docker exec  my-py-flask ps -ef`{{execute}}

Or log-in to container 

`docker exec -it my-py-flask /bin/sh`{{execute}}


### Manipulate image 

