we need to create a docker image for the voting app so we will go into vote directory

`cd vote`{{execute}}

python based Dockfile for the voting app

`cat Dockerfile`{{execute}}

Buld the voting app and tagged as "voting-app"

`docker build . -t voting-app`{{execute}}

New image of voting-app created you  can see by images list command

`docker images`{{execute}} 

Run the voting-app and publish a port to 5000 to 80 

`docker run -p 5000:80 voting-app`{{execute}}

Check on browser. Vote page load, click on vote shows the error page

https://[[HOST_SUBDOMAIN]]-5000-[[KATACODA_HOST]].environments.katacoda.com

Run the redis </b>

`docker run -d --name=redis redis`{{execute}}


Run the voting-app in detached mode using -d and link with the "redis"</b>

`docker run -d -p 5000:80 --link redis:redis voting-app`{{execute}}

Again check the browser now no error </b> 

https://[[HOST_SUBDOMAIN]]-5000-[[KATACODA_HOST]].environments.katacoda.com

</b>
`docker ps`{{execute}}


