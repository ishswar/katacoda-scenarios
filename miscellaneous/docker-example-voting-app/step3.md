CD to worker folder, worker based on .net and link with both redis and postgres database

`cd /root/example-voting-app/worker`{{execute}}

Build worker-app from the Dockerfile

`docker build . -t worker-app`{{execute}}


Before run run the postgres 

` docker run -d --name=db -e POSTGRES_PASSWORD=postgres postgres:9.4`{{execute}}

Once image is build, now run the worker-app and link with redis and db

`docker run -d --link redis:redis --link db:db worker-app`{{execute}}

`docker ps`{{execute}}








