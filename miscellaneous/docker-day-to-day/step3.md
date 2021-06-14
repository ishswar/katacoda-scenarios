
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
1. `ENTRYPOINT`

## Build image 

Check what images are already there on machine `docker images`{{execute}}

Now make sure you are in directory `py-flask`
Run command `docker build -t my-py-flask:1.0.0 .`

If above command finishes successfully you just containerized your first application 

Re-run `docker images` and you should see now new image added `my-py-flask:1.0.0` to docker images on your machine.  
You will also see one extra image `python:3.6` we will talk about it.