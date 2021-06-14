# Run python application 

`docker run --detach --publish 8787:8080 ishswar/webpyapp:1.0.1`{{execute}}

## Is it running ? 

`docker ps`{{execute}}

### How about web app ? 

`curl http://localhost:8787`{{execute}}

### Check in browser 

[Open in Browser](https://[[HOST_SUBDOMAIN]]-8787-[[KATACODA_HOST]].environments.katacoda.com)

# Time to cleanup 

## Stop running container 

`CONTAINER_ID=$(docker ps -q)`{{execute}}
`echo "Stopping container with ID ($CONTAINER_ID)" && docker stop $CONTAINER_ID`{{execute}}

## Removed stop container 

`docker rm $CONTAINER_ID`{{execute}}

Check ***nothing*** is running 

`docker ps -a`{{execute}}
