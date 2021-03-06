Section 1 (Core Concepts)
=========

Question 1
----------
Create a namespace called ggckad-s0 in your cluster.
Run the following pods in this namespace.

1. A pod called pod-a with a single container running the 
   kubegoldenguide/simple-http-server image
2. A pod called pod-b that has one container running the
   kubegoldenguide/alpine-spin:1.0.0 image, and one container 
   running nginx:1.7.9

Write down the output of `kubectl get pods` for the ggckad-s0 namespace.


Question 2
----------
All operations in this question should be performed 
in the ggckad-s1 namespace.

Start a new Dockerfile in this directory based off 
the kubegoldenguide/alpine-spin:1.0.0 image.

Customize this Dockerfile to copy questions.txt from this directory
to /etc/questions.txt in the Docker image

Build the Docker image and tag it with ggckad-question-two.

Run a pod that uses this Docker image. It should have the 
label 'question' set to 'two' and the annotation 'method' set
to 'Docker build'.

Because we are using a local Docker image,
you may need to set `imagePullPolicy: Never` in your pod.


Question 3
----------
There are three deployments running in the ggckad-s1 namespace.
Get a list of all of the pods that have the label 'tier' set to 'frontend'.

Are there any pods with the label 'app' set to 'nginx' 
that don’t also have the label 'tier' set to 'frontend'?


Question 4
----------
There is a pod running in the ggckad-s1 namespace that has 
the annotation 'author' set to 'Matthew Palmer'.
Find that pod.
Edit the pod so that the 'author' annotation is set to your name.



Section 2 (Configuration)
=========

Question 5
----------
All operations in this question should be performed in
the ggckad-s2 namespace.

Create a ConfigMap called app-config that contains the following
two entries:

- 'connection_string' set to 'localhost:4096'
- 'external_url' set to 'google.com'

Run a pod called question-five-pod with a single container running
the kubegoldenguide/alpine-spin:1.0.0 image, and expose these 
configuration settings as environment variables inside the container.


Question 6
----------
All operations in this question should be performed in
the ggckad-s2 namespace.

Create a Secret called user-login that contains two entries

- 'username' set to 'kubepracticeexam'
- 'password' set to 'success'

Create a pod with a single kubegoldenguide/alpine-spin:1.0.0 container. 
Add these secrets as a volume in your pod, and mount the 
entries into this container's filesystem at /etc/secrets.

Note that you may need to use the `base64` unix utility


Question 7
----------
All operations in this question should be performed in
the ggckad-s2 namespace.

Create a pod that has two containers. Both containers should
run the kubegoldenguide/alpine-spin:1.0.0 image. 
The first container should run as user ID 1000, and the second 
container with user ID 2000.

Both containers should use file system group ID 3000.


Question 8
----------
All operations in this question should be performed in
the **ggckad-s2-rq** namespace.

Create a pod in the ggckad-s2-rq namespace that runs a 
single container with the nginx:1.7.9 image.
This container has minimum resource requirements of 128m memory
and 0.5 CPU. Ensure that the pod will have these requirements met
and can run correctly.

After the pod has been created, find out how much memory is still
available to be requested in the ggckad-s2-rq namespace.


Question 9
----------
All operations in this question should be performed in
the ggckad-s2 namespace.

Create a pod called 'question-nine-pod' with a container
running the nginx:1.7.9 image. This pod needs to be able to make API requests 
to the Kubernetes API Server using the 'automated-access' service account.

Create the pod from YAML.



Section 3 (Multi-Container Pods)
=========

Question 10
-----------
All operations in this question should be performed in
the ggckad-s3 namespace.

In the ggckad-s3 namespace there is currently a pod running called
question-ten-pod. This pod has a single container that writes the
current date and time to /var/log.txt every ten seconds.

In the resources directory, you'll find a question-10.yaml file that was
used to create this pod. We will be updating that file.

In the resources directory, there is a Dockerfile for a log collector image.

Build the Docker image and tag it as question-ten-collector.

Add the new Docker image as a sidecar container alongside the
currently running container in the pod by editing the YAML file.

Recreate the running pod to include the sidecar container.


Question 11
-----------
All operations in this question should be performed in
the ggckad-s3 namespace.

In the resources directory, there is a file called question-11.yaml
that configures a pod. This pod writes to a new data file in
/var/data every five seconds.

We have a third party service that is going to collect
these data files. However, the service requires that all of
the data is concatenated together and inserted into a file 
located at /collect/data.txt.

Update the pod to include an adapter container that concatenates 
the individual data files using `cat /var/data/*` every ten seconds, 
and writes the concatenated output to /collect/data.txt.

(Don't worry about cleaning up the already-collected files, simply
write the output of `cat /var/data/*` to the /collect/data.txt file
in the adapter container's filesystem.)

Question 12
-----------
All operations in this question should be performed in
the ggckad-s3 namespace.

In the resources directory, there is a file called question-12.yaml
that configures a pod. Currently, this pod has a single container
that makes requests directly to google.com every minute.

We would like these requests to be proxied through an ambassador container
for auditing and logging purposes. The ambassador container should use the
kubegoldenguide/question-twelve-ambassador Docker image.

Update the pod to include the ambassador container, and update the 
existing container so that it makes requests through the proxy.
The ambassador is available at 'localhost:7000'.



Section 4 (Observability)
=========

Question 13
-----------
All operations in this question should be performed in
the ggckad-s4 namespace.

This question will require you to create a pod that runs the
image 'kubegoldenguide/question-thirteen'. This image is in the main
Docker repository at hub.docker.com.

This image is a web server that has a health endpoint served at '/health'.
The web server listens on port 8000. (It runs Python’s SimpleHTTPServer.)
It returns a 200 status code response when the application is healthy.
The application typically takes sixty seconds to start.
Create a pod called question-13-pod to run this application, making sure
to define liveness and readiness probes that use this health endpoint.


Question 14
-----------
Say we had a pod called "file-worker" that had three containers,
'file-watcher', 'file-uploader', and 'file-processor'. The last 
time the pod was run, the 'file-uploader' container failed.
What kubectl command would you use to inspect the logs for this container?


Question 15
-----------
Run a kubectl command that outputs the total amount of CPU requests
and memory requests for each node. What is the total capacity of memory
available in your cluster? Write down the command and these amounts.


Question 16
-----------
All operations in this question should be performed in
the ggckad-s4 namespace.

In the resources directory, there is a file called question-16.yaml
that declares a pod. This pod should write the current date 
to a file every five seconds. Create the pod. It looks like everything
should be working, but the date isn't being written to the file correctly.

Inspect the YAML file and the running pod and diagnose the issue.
Then, fix the issue and recreate the pod so that it works as expected.


Question 17
-----------
All operations in this question should be performed in
the ggckad-s4 namespace.

In the resources directory, there is a deployment 
declared in question-17.yaml. Try to create the deployment 
declared in this configuration file. You will find that 
the deployment has failed. 

Fix the configuration file, then create the deployment. 
Then use kubectl to get the list of events related to the deployment.



Section 5 (Pod Design)
=========

Question 18
-----------
All operations in this question should be performed in
the ggckad-s5 namespace.

In the resources directory, there is a pod declared in question-18.yaml.

Update this YAML file so that the pod has the labels 
app=nginx and tier=backend, and update the pod's annotations
to set commit=6fede89 and stream=practice-exam.

Create the pod in the ggckad-s5 namespace.


Question 19
-----------
All operations in this question should be performed in
the ggckad-s5 namespace.

Use label selectors to get the list of resources that have labels
tier=frontend and app=nginx, or have tier=backend.

Write down the kubectl commands you used and the list of
resources.


Question 20
-----------
All operations in this question should be performed in
the ggckad-s5 namespace.

Create a file called question-20.yaml that declares a deployment
in the ggckad-s5 namespace, with six replicas running the 
nginx:1.7.9 image. Each pod should have the label app=revproxy.
The deployment should have the label client=user.

Configure the deployment so that when the deployment is updated,
the existing pods are killed off before new pods are created to
replace them.


Question 21
-----------
All operations in this question should be performed in
the ggckad-s5 namespace.

There is a deployment called question-21-deployment running
in the ggckad-s5 namespace. 

Edit the deployment so that it has five replicas of a pod 
running the 'python:2.7-alpine' image.

Get the roll out history of the deployment.

Get the status of the roll out for the edited deployment.

Roll back the deployment to the previous version, 
and get the status of the deployment after it's been rolled back


Question 22
-----------
All operations in this question should be performed in
the ggckad-s5 namespace.

Create a Job called question-22-job that generates a random 
number between 1 and 100. The Job should re-run until it 
generates a number greater than 50. You may implement this 
using any image or language you like.


Question 23
-----------
All operations in this question should be performed in
the ggckad-s5 namespace.

In the resources directory, there is a file called 
question-23.yaml that declares a Job that checks if 
there are more than eight processes running. 

Currently, the Job reports a failure if there are less than
eight processes running.

You need to make two changes to this file:

1. Update the Job configuration so that it succeeds if there are 
   less than eight processes running, and fails if there
   eight or more processes running

2. Modify or copy and change this Job declaration so that 
   Kubernetes will run this check repeatedly, every minute.

Delete the old job, and create the new recurring object.
Verify the new object worked two consecutive times.


Section 6 (Services & Networking)
=========

Question 24
-----------

All operations in this question should be performed in
the ggckad-s6 namespace.

Using a single kubectl command, create a deployment of the nginx:1.7.9
image called question-24-deployment running with five replicas. 
Write down this command.

Once the deployment is running successfully, expose the deployment's
pods so that network requests can be made to them from outside the cluster.

It may be helpful to know that, by default, the nginx image listens on port 80.

Question 25
-----------

All operations in this question should be performed in
the ggckad-s6 namespace.

In the resources directory, there is a file called question-25.yaml that
declares three pods running the nginx:1.7.9 image in our backend tier.

We want to expose these pods via a unified network interface, 
so we also declare a Service in that YAML file.

When we create the resources declared from that file (using
`kubectl create`), everything looks like it's working... but requests to the 
service aren't getting any response! Fix the Service declaration so that
requests can be made to these nginx pods through the Service. 
Note that the Service is currently, and must remain, internal to the cluster.


Question 26
-----------

All operations in this question should be performed in
the ggckad-s6 namespace.

This question builds on the pods and service created in question 25.

Now that we've fixed the service and requests can be made to the pods
from inside the network, update the service so requests can be made to
it from outside the cluster. It should be made available on port 30456
on each node.


Question 27
-----------

All operations in this question should be performed in
the ggckad-s6 namespace.

In the resources directory there is a YAML configuration file called
question-27.yaml.

This YAML file declares two pods. The first pod simulates a pod running
a database. The second pod simulates a pod running a web application.

As it is currently configured, incoming and outgoing network requests 
can be made between any pod in this file. However, we want to configure
a Network Policy that restricts network traffic.

Add labels to these pods, and create network policies so that:

* allows incoming and outgoing network requests for the web application pod
* only allows incoming network requests for the database pod if they are 
  made from the web application pod
* disallows outgoing network requests for the database pod



Section 7 (State Persistence)
=========

Question 28
-----------

All operations in this question should be performed in
the ggckad-s7 namespace.

In this question, you will create and use a persistent volume.

First, create a Persistent Volume resource in your cluster. It should be 
called question-28-pv, allow for 1Gi of storage capacity, be of type
hostPath with path /data/persistent-volume, and allow for ReadWriteOnce access.

Second, create a Persistent Volume Claim in your cluster that makes a 
request for this Persistent Volume resource. It should be called
question-28-pvc and needs to request 512Mi storage.

Third, create a Pod in your cluster that can use this persistent volume.
It should be called question-28-pod, run the nginx:1.7.9 image, and mount the
persistent volume at /etc/question-28-data.


