`cd /root/example-voting-app/result`{{execute}}

To check the resulting-app Dockerfile content 

`cat Dockerfile`{{execute}}

`docker build . -t resulting-app`{{execute}}

`docker images`{{execute}}

Run the image in detached mode using -d, link it with db and publish port 5001 to 80

`docker run -d -p 5001:80 --link db:db resulting-app`{{execute}} 


Open resulting-app page in browser

https://[[HOST_SUBDOMAIN]]-5001-[[KATACODA_HOST]].environments.katacoda.com

  




