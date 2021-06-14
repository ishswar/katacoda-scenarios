
# Containerize the application 

Let's get a source code for Python application

`git clone https://github.com/pranay-tibco/py-flask.git`{{execute}}


## Understanding the Application 

Few key things about web app 

1. It has few end-points `/visits-counter` & `/delete-visits/`
1. It take an system level environment variable `HTTP_PORT` to set HTTP Port to start on 
1. Once it start the app it print line `Starting server on Port:` with HTTP Port that it's starting on 

## Understanding Docker file 

It has Docker **directive**(s) 

1. `FROM`
1. `RUN`
1. `COPY`
1. `EXPOSE`
1. `WORKDIR`
1. `ENV`
1. `LABEL`
1. `ENTRYPOINT`

## Build image 

Check what images are already there on machine `docker images`{{execute}}

Now make sure you are in directory `cd py-flask`{{execute}}
Run command `docker build -t my-py-flask:1.0.0 .`{{execute}}

If above command finishes successfully you just containerized your first application 

Re-run `docker images`{{execute}} and you should see now new image added `my-py-flask:1.0.0` to docker images on your machine.  
You will also see one extra image `python:3.6` we will talk about it.

## Create a container out of image 

In other words we have a image let's run that image - that creates a container 

Command : `docker run -d -p 8787:8080 --rm --name my-py-flask my-py-flask:1.0.0`{{execute}}

Port `8787` is arbitrary you can pick any port; but port `8080` is fixed as this is defined by Image  

Let's talk about switches in above command 

1. `-d` or `--detach` 
1. `-p` or `--publish` 
1. `--rm` 
1. `--name`

### Access the web app 

We can check this from command line using `curl` 

`curl http://localhost:8787/visits-counter/`{{execute}}

### Check in browser 

We can also check web application using this link  [Open in Browser](https://[[HOST_SUBDOMAIN]]-8787-[[KATACODA_HOST]].environments.katacoda.com/visits-counter/)
