The Katacoda `terminal` UI Layout provides a full Terminal experience. 

# Namespace and cgroup - playing around 

`docker run -d --name nstest ubuntu sleep 3600`{{execute}}
`PID=$(docker inspect --format {{.State.Pid}} nstest)`{{execute}}

This command demo how `docker exec` works 

`nsenter --target $PID --mount --uts --ipc --net --pid`{{execute}}

Above command will put you inside the container just as `docker exec` would have done

`exit`{{execute}}
`docker stop nstest -t 1`{{execute}}



`docker run --rm -d --memory=512m --name memtest ubuntu sleep 3600`{{execute}}
`docker exec -it memtest /bin/bash`{{execute}}
`free -mt`{{execute}}

Open new terminal - or in new terminal run this command 
`docker events`

Back to main terminal run below command it will not run - it will get killed with OOM as it exceeds limits 
`cat <( </dev/zero head -c 650m) <(sleep 300) | tail`{{execute}}

In our `docker events` terminal we will see `OOM` message

Sample output  
```BASH
controlplane $ docker events
2021-03-04T18:53:35.582647009Z container oom 969854edebcfbb29df2aa44b8ac416b6b265c5d35f655927a8bc84f4dd95ce14 (image=ubuntu, name=nstest)
```

This should work 
`cat <( </dev/zero head -c 350m) <(sleep 60) | tail`{{execute}}

We are done clean up 

`exit`
`docker stop memtest -t 1`{{execute}}

CPU Test 

`docker run --rm -d --cpus="1" --name cputest ubuntu sleep 3600`
`docker exec -it cputest /bin/bash`
`apt-get update && apt-get install stress`
`stress --cpu 2 --timeout 60`

Open new terminal 

`top`

```
top - 18:43:11 up 38 min,  2 users,  load average: 0.36, 0.47, 0.27
Tasks: 106 total,   3 running,  58 sleeping,   0 stopped,   2 zombie
%Cpu(s): 49.8 us,  0.0 sy,  0.0 ni, 49.7 id,  0.0 wa,  0.0 hi,  0.0 si,  0.5 st
KiB Mem :  2040680 total,   520624 free,   220740 used,  1299316 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  1676628 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                         
12808 root      20   0    3860    100      0 R  50.3  0.0   0:02.78 stress                          
12807 root      20   0    3860    100      0 R  49.7  0.0   0:02.75 stress                          
    1 root      20   0  159904   9080   6680 S   0.0  0.4   0:03.41 systemd       
```

`docker stop cputest -t 1`