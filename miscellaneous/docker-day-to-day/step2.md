# Run python application 

`docker run --detach --publish 8787:8080 ishswar/webpyapp:1.0.1`{{execute}}

Above command will run python based web application - this needs a flask framework.  
We are able to run this application without worrying about all dependency thanks to Containerization  

We will go over switches `--detach` and `--publish` in detail soon. 

### Is Container running ? 

First let's check if Container is running or not 

`docker ps`{{execute}}

### How about web app ? 

We can check this from command line using `curl` 

`curl http://localhost:8787`{{execute}}

### Check in browser 

We can also check web application using this link  [Open in Browser](https://[[HOST_SUBDOMAIN]]-8787-[[KATACODA_HOST]].environments.katacoda.com)

# Time to cleanup 

Above `run` command downloaded image from docker hub (zipped up) , unzipped it and than started container process  
Let's top container process and clean container files. 

## Stop running container 

First we will stop running container 

`CONTAINER_ID=$(docker ps -q)`{{execute}}
`echo "Stopping container with ID ($CONTAINER_ID)" && docker stop $CONTAINER_ID`{{execute}}

## Removed stop container 

Is container really gone ? `docker ps -a`{{execute}} 
Stopping the container does not remove container from file system - let's clean up container from file system.

`docker rm $CONTAINER_ID`{{execute}}

Check ***nothing*** is running 

`docker ps -a`{{execute}}

## Container image 

Above `run` command also downloaded image from docker.com that is still there you can check that via command  

`docker images`{{execute}}
