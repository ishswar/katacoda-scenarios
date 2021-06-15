
# Ship it 

## Send our image to docker hub  

First we need to log-in to Docker hub - password will be provided during session

`docker login -u amxkonex`{{execute}}

## Tag image

We will create a unique name for our image - so we will use tag part of image to be unique

`MY_IP=$(curl -s ifconfig.me)`{{execute}}

Use our IP to tag our image 

`docker tag my-py-flask:1.0.0 amxkonex/day-do-day:$MY_IP`{{execute}}

## Push image 

Time to push image to docker hub - use below command to push to Docker hub

`docker push my-py-flask:1.0.0 amxkonex/day-do-day:$MY_IP`{{execute}}

## Check Docker hub 

Check on this page : [Docker hub](https://hub.docker.com/r/amxkonex/day-do-day/tags?page=1&ordering=last_updated)