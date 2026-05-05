## monitoring, alarm management and autoscaling

- [monitoring, alarm management and autoscaling](#monitoring-alarm-management-and-autoscaling)
- [what is better than monitoring?](#what-is-better-than-monitoring)
  - [what is worse](#what-is-worse)
  - [what is better](#what-is-better)
  - [Better than a dashboard](#better-than-a-dashboard)
  - [how to load a dashboard](#how-to-load-a-dashboard)
  - [different types of testing](#different-types-of-testing)
- [apache bench](#apache-bench)
- [creating a GPU usage alarm](#creating-a-gpu-usage-alarm)


## what is better than monitoring?
- the systematic, continupus process of watching, checking and recording data or situations over time to assess progress or detect changes
- provides info about applications performance and usage
### what is worse
- not monitoring
- not watching cpu so its too high can cause app to crash

### what is better
- cloud watch monitoring
- watches CPU load, CPU utilisation provides at intervals to see big picture
- create a dashboard to show usage 
  - cons: very comples, overwhelming volume of info, constant monitoring required

### Better than a dashboard
- set up an alarm
- provides notification if cpu usage is too high
- even better if there is autoscaling, if the load isnt so high then less instances of the app
- usually platform for a service provides this for you

### how to load a dashboard
1. go to running app instance and scroll down to monitoring
2. press manage detailed monitoring, enable and confirm (detail monitoring has extra charges)
3. press three dots to add to dashboard and create a new one and add dashboard
- once the dashboard is created:
  - delete graphs with data that is not needed (CPU credit balance, CPU credit usage, metadata)
  - expand certain graphs to improve visualisation
  - edit time scales (1 minute, 5 minutes) to see CPU utilisation over different time scales (can not view below 1 minutes as measurements taken every minute)

![alt text](image-2.png) 


### different types of testing
1. load testing (load/manual)
  - test if the app can handle many requests over time
2. stress testing
  - create system pressure
  - use sudo apt-get update -y & sudo apt-get upgrade -y to test
3. using apache

<br>


![alt text](image.png)

- first peak is load testing
- second peak is stress testing
- final peak is using apache


## apache bench

- command line tool used to test performance of web servers
- it measures:
  - how fast server responds to http requests
  - how many it can handle
  - when it starts to slow down
- simulates many users accessing the web server
- can be used to test cpu utilization

Format for ab command
```
ab -n 1000 -c 100 http://34.244.178.140/
```
- '-n' : number of requests (1000 requests)
- '-c' : make 100 requests at a time
- ends with server being tested

## creating a GPU usage alarm

- follow this link for help
  - https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/US_AlarmAtThresholdEC2.html

1. create an alarm and choose the ec2 metrics
2. find the instanceid of your instance and select the row with cpu utilization
3. choose a period of 1 minute for a quicker alarm activation in the specify metric and conditions tab
4. for whenever cpuutilization tab, choose a suitable threshold that can be activated by testing
5. press next and then create a new sns topic that includes your email so you recieve a notifcation
6. enter your name for the next part and then next and finally preview it, and then create it
- once you test your app servers and reach above the threshold, you will recieve an email like so

![alt text](image-3.png)
