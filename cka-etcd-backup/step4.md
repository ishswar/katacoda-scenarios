Scenario 3

## Chronic pain 

Our intern wrote a `CronJob` to send some Marketing/Auditing data periodically to our Sales team. Last few E-mails have not 
gone out . Your job is find out what is going on with this cron jobs . Find a issue and fix it (no need to recreate it - just 
modify them in-place . Once you are able to fix it make sure you are able to see that (new) Jobs are getting created and they are geting 
completing in timely manner. We don't know in what namespace they belong.  

Write a reason for this disruption in `/root/chronicpain/reason.txt`{{copy}}

### Use Context 

`kubectl config use-context k3d-k8s`{{copy}}