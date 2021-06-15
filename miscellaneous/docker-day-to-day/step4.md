
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

`docker exec  my-py-flask-app ps -ef`{{execute}}

Or log-in to container 

`docker exec -it my-py-flask-app /bin/bash`{{execute}}

look around inside the container 

`hostname`{{execute}}  
`ps -ef`{{execute}}  
`free -mt`{{execute}}  
`df -h`{{execute}}
`env`{{execute}}    

### Manipulate image 

Let's edit the python code 

First we need to install `nano` text editor 
`apt-get update`{{execute}}  
`apt-get install nano -y`{{execute}}

Now edit the file 
`nano app.py`{{execute}}

Add word `tibco` anywhere in file 

exit out of the container `exit`{{execute}}

### Stop and Start container 

First stop the container 

`docker stop my-py-flask-app`{{execute}} - This will take 10 seconds 

Let's inspect the container (yes you can use same command `inspect` to see container metadata)

`docker inspect my-py-flask-app`{{execute}}

#### Where is app.py stored now on disk ? 

`COPY_ON_WRITE_LAYER=$(docker inspect my-py-flask-app | jq .[0].GraphDriver.Data.UpperDir -r)`{{execute}}

Search for word "tibco" that we added during editing `app.py`

`grep -r -H "tibco" $COPY_ON_WRITE_LAYER`{{execute}}

You can see `docker stop` does not destroy container it persists the updated/modified files.

#### Restart the app and see if word "tibco" is there in reply 

`docker start my-py-flask-app`{{execute}}

Hit the URL again 

`curl http://localhost:8787/visits-counter/`{{execute}}

You should see output like this 

```bash
$ curl http://localhost:8787/visits-counter/
Hello from tibco Server [f7c9a7c8bf71] Total visitors on this server : 1
```

## Clean things up 

Stop container 
`docker stop my-py-flask-app`{{execute}}

Remove container from file system 
`docker rm my-py-flask-app`{{execute}}

