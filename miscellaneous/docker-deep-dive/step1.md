The Katacoda `terminal` UI Layout provides a full Terminal experience. 

# Namespace and cgroup - playing around 

`docker run -d --name nstest ubuntu sleep 3600`{{execute}}

`PID=$(docker inspect --format {{.State.Pid}} nstest)`{{execute}}

This command demo how `docker exec` works 

`nsenter --target $PID --mount --uts --ipc --net --pid`{{execute}}

Above command will put you inside the container just as `docker exec` would have done

`exit`{{execute}}
`docker stop nstest -t 1`{{execute}}

## Memory test

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

## CPU Test 

First we run container without any CPU limits 

`docker run --rm -d --name cputest ubuntu sleep 3600`{{execute}}

`docker exec -it cputest /bin/bash`{{execute}}

`apt-get update && apt-get install -y stress`{{execute}}

`stress --cpu 2 --timeout 60`{{execute}}

Open new terminal 

`top`{{execute}}

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
Back in main terminal - do cleanup 

`exit`{{execute}}
`docker stop cputest -t 1`{{execute}}

Now we run it with CPU limites 

`docker run --rm -d --cpus="1" --name cputest ubuntu sleep 3600`{{execute}}

`docker exec -it cputest /bin/bash`{{execute}}

`apt-get update && apt-get install stress`{{execute}}

`stress --cpu 2 --timeout 60`{{execute}}

Open new terminal 

`top`{{execute}}

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
Back in main terminal - do cleanup 

`exit`{{execute}}

`docker stop cputest -t 1`{{execute}}

## Create your own cgroup 

Install control groups utility

`apt-get update && apt-get install cgroup-bin tree -y`{{execute}}

Let say we want to create create cgroup that limits process to one(1) CPU . We are not setting cpu affinity we are setting
out of all avalable compute capacity on host how much process can use.

let's call our `cgroup` - `mycputest` - below command will create that

`sudo cgcreate -a $USER -g cpu:mycputest`{{execute}}

These creates bunch of files under `/sys/fs/cgroup/cpu/mycputest` (`tree /sys/fs/cgroup/cpu/mycputest`{{execute}} ) 

For now we care about below two files 

`cat /sys/fs/cgroup/cpu/mycputest/cpu.cfs_quota_us`{{execute}}  
`cat /sys/fs/cgroup/cpu/mycputest/cpu.cfs_quota_us`{{execute}}

In order to set it to use **1 cpu** we set both the values to `100000`

`cgset -r cpu.cfs_quota_us=100000 mycputest`{{execute}}  
`cgset -r cpu.cfs_period_us=100000 mycputest`{{execute}}

On this machine we have 2 cpus ( you can use command `lscpu`{{execute}} to find that out)
Our new cgroup will limit any application using that cgroup to use only 1 cpu capacity out of that.

```
$ lscpu
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              2
```
Let's test that 

First let's install stress tool on host machine 

`apt-get update && apt-get install stress`{{execute}}

Open **new** terminal - run `top`{{execute}} command

Back in main terminal run command - if `cgroup` is working as expected than our stress program should not be taking
more than 50% of CPU   

`cgexec -g cpu:mycputest stress --cpu 2 --timeout 60`{{execute}}