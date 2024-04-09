# Monitoring 101

- Module: **Linux Administration** 
- Competence: `is able to gather information about the state of a linux machine`
- Type of Challenge: `Consolidation`
- Duration: `3 day`
- Deadline: `09/04/2024`
- Participants: : `solo`

## The Mission

[Here](https://github.com/becodeorg/BXL-k4MK4r-2/blob/main/content/02-Linux/09-Projects/02-Monitoring_101.md) is the summarized scope of this project.

## The report 📝

### Introduction 
After going into the theory in the above PDF file, let's use the tools mentionned to monitor our own machine.

### Client Structure 🧱

The client on which we'll be performing our monitoring test has the following specs:

o	Hardware components : virtual machine with 4gb of ram, 40gb of virtual HDD and 2 CPU's
o	OS: Debian 12.5 in a Virtualbox instance

### Monitoring :satellite:

Let's have a first look at our general parameters by running Htop. Install it first if you don't have it !

````
sudo apt install htop
````
````
htop
````

![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/a314dfc0-6ca8-42c5-a362-6e6f9340adc4)

The memory seems to be quite used, but besides this everything looks normal.
Let's dig deeper.

#### CPU usage 💻

We'll use the command mpstat that can be launched after installing the sysstat package. Therefore :

````
sudo apt install sysstat
````
````
mpstat
````
![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/a8bac613-6db2-4973-b0a8-acbc71ffe23e)

As you see above, we have a very high "Idle" usage being spotted by the command. This only indicates the percentage of the processor *not* being used  by any program. So, basically, this is the processing capacity being still available. We can conclude that our current CPU load is decent and that there doesn't seem to be any visible problem.
Both our processors can be inspected by typing the command :

````
mpstat -P ALL
````

#### Memory load ⚖️

After typing the command "free", this is the output we get :
![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/051a3fd6-d3d3-44dc-b96c-cec581d6948b)

Doesn't show much, but here we see that a higher percentage of our memory capacity is used. We'll dig deeper into this by typing the "top" command which will list us (among other things) the full list of processes running and their respective memory use. The options for the "top" command here below only ensure we can list our processes according to their use of the computer's memory, from higher to lower :

````
top -o %MEM
````
![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/6c563754-9731-4638-81a6-120243a1df66)

All "Gnome" daemons aren't worrying, as they're all related to our desktop environment. Not taking these into account, we still see (among the highest "RAM-consuming" programs) "fwupd", some "evolution" programs and a program called "tracker-miner". LEt's do some research on these:

- fwupd: it is the daemon for managing the installation of firmware updates. This is 🆗
- evolution: this is Debian's default mail manager. This is 🆗
- tracker-miner: this is Debian's indexing system for making it faster to search for files when they're recorded in the database. This is 🆗

Everything seems to be normal for now, so we won't need to go in more details. Should you need to, the "PID" of each processes is useful as this can be used to investigate further and kill them, freeing therefore the RAM usage they were occupying.

#### HDD/SDD space 💾

The "iostat" command will here give us an overview over the HDD/SDD activities in terms of writing and reading :

![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/9dddfa6f-be87-4021-88d3-28b6aa7b5d95)

No further research is needed, as very little activity is noticed. 

#### Network traffic :chart_with_upwards_trend:

You'll have to install the "iftop" command and run it as sudo for monitoring the network activity.

````
sudo apt install iftop
````
````
sudo iftop
````

![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/b3c1ab1a-4bc7-414a-a6a2-837c7217e5af)

The only activity spotted here are linked to this url called "mdns.mcast.net". What is it ?
It turns out that this is merely the mDNS protocol, which helps computers on small networks do DNS request without having to configure anything. This may be explained by the fact we installed packages in the virtual machine while using our "main computer's" wifi.
No issue with this then, for now at least.

#### Power usage 🔋

This can be investigated after installing and launching the "Powertop" package :

````
sudo apt install powertop
````
````
sudo powertop
````


As we can see, this doesn't give us any power consumption data. After research, it turns out that this program may need to run for a few days before being able to calculate the power consumed by daemons/programs on the machine.

Let's install and run the "powerstat" program then :

````
sudo apt install powerstat
````
````
sudo powerstat
````

![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/6280c633-c2e5-4e7a-abab-0e539f45f3fc)

![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/1c5deeba-55af-4a2c-8f1d-eb8472c80e26)

We stopped the analysis after some lines, but it seems that the consumption remains the same for the duration of the analysis. It'd need to be run for a longer period in time to spot any weird changes, but for now it seems goot enough.

#### Users’ activities 🖋️

Conclusively, we can have a look at what our user's did but it wouldn't make much sense since there's only one user (myself).

### Conclusion 🌻

As this was done on my own machines without much programs running, this first monitoring analysis didn't return much information but it was an interesting look under the hood of a running OS !
