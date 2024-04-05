# Project context 📖
The local library in your little town has no funding for Windows licenses so the director is considering Linux. Some users are sceptical and ask for a demo. The local IT company where you work is taking up the project and you are in charge of setting up a server and a workstation.
To demonstrate this setup, you will use virtual machines and an internal virtual network (your DHCP must not interfere with the LAN).

You may propose any additional functionality you consider interesting.

## Must Have : ✔️ 

Set up the following Linux infrastructure:

1. One server (no GUI) running the following services:
    - DHCP (one scope serving the local internal network)  isc-dhcp-server
    - DNS (resolve internal resources, a redirector is used for external resources) bind
    - HTTP+ mariadb (internal website running GLPI)
    - **Required**
        1. Weekly backup the configuration files for each service into one single compressed archive
        2. The server is remotely manageable (SSH)
    - **Optional**
        1. Backups are placed on a partition located on  separate disk, this partition must be mounted for the backup, then unmounted

2. One workstation running a desktop environment and the following apps:
    - LibreOffice
    - Gimp
    - Mullvad browser
    - **Required** 
        1. This workstation uses automatic addressing
        2. The /home folder is located on a separate partition, same disk 
    - **Optional**
        1. Propose and implement a solution to remotely help a user

## How will we do this? ⁉️

We'll install two virtual machines on Virtualbox so that we can simulate this small local network. Both machines will have two ethernet adapters so that we can ensure they can download their packages from the internet, BUT so that we can still check if our local network between them works.

# Setup 
## Client side (workstation) 💻

Specs : 
- [ ] Debian 12.5 as a Graphical installation
- [ ] 4 gb memory
- [ ] 2 processors
- [ ] 40 gb of space on the virtual HDD
- [ ] The "nala" package manager will be installed and used instrad of the "apt" package manager one, as it's a nicer interface for installing applications via the CLI.
- [ ] Username : "library"; password : "library"
- [ ] Root password : "library"
- [ ] Language : French (so that our keyboard keys match our input)

Although it isn't safe for a real-life project, we've set both user and root password to "library", and our user name to "library" as well so that any installation process would be easy. Proper safety feature would be to set a passphrase password to the root user, therefore ensuring our library worker wouldn't get admin access to his/her system.

### Walkthrough of the requirements' installation 1️⃣ 2️⃣ 3️⃣ 
#### [Nala](https://gitlab.com/volian/nala)
You can find more info on this project above.
It is easily installed via the apt-command (before which we swith to root mode for the easiness of installing everything:
```
su -
apt install nala
```
![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/d358d36a-3831-4d8c-a9fa-9baa09d85d09)
#### LibreOffice 
This is installed by default on the GUI version of Debian 12.5, so nothing to do here.
![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/7dabad6f-58e6-427e-8300-8b2f4923d17c)
#### Gimp
This can be easily install via the terminal and our newly installed nala package manager
![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/e9433d3a-09d3-42e5-bae3-2bc1ddbf3a7a)
![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/643df95e-87c8-47b1-b898-fda8b9668a83)
#### Mullvad browser
For this browser, we have to follow the [tutorial](https://mullvad.net/fr/help/install-mullvad-browser) placed on their website, which is quite self explanatory.
And as you can see, it succesfully installed!
![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/ea74fa9e-ac16-448c-b1c9-b300db930aa5)
#### Automatic addressing via DHCP
If we go into our client's network interfaces and connect it to the enp0s8 interface (the one that's connected to the same network our DHCP server is in), we can see that our client can get its IP address very easily :

![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/c488e45d-a736-443f-a82c-e681e8cadf8f)

#### The /home folder is located on a separate partition 
This was done during the installation of the VM, as it then asked us if we wanted to partition our disk. Since we answered yes, it then asked us, among multiple choices, if our /home partition had to be separated. To which we agreed.
The result is then displayed via the terminal.
![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/a3a0bbd8-46f2-48a3-81d1-8625c1dcf5de)

With this, we basically have set-up the mandatory requirements for our library's workstation !






## Server side 💾 

Specs : 
- [ ] Debian 12.5 as a CLI installation
- [ ] 4 gb memory
- [ ] 2 processors
- [ ] 40 gb of space on the virtual HDD
- [ ] Username : "server"; password : "server"
- [ ] Root password : "server"

Just like for the client, we'd obviously advise to change these passwords for a real-life project as they're not safe.

### Walkthrough of the requirements' installation 1️⃣ 2️⃣ 3️⃣ 
#### SSH connection to our server
Since this'll make our job easier as we'll be able to copy-paste commands to install our services, we'll install an SSH solution on the server so we can get access to it from our computer.
[Here](https://phoenixnap.com/kb/how-to-enable-ssh-on-debian) are the instructions we followed.

Of course, take into account that our own IP address was different as shown here below :

![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/49fc82a2-7e48-4cca-ad8f-7c999de746f0)

#### DHCP via the isc-dhcp-server service 📋 
We install the DHCP service via a simple command :
```
apt install isc-dhcp-server
```
But it seems to bug, so we'll inspect this by following the CLI's advice :

![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/934cd774-78f1-4b1b-811a-4cbb2ca1ca5d)
![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/fd8b9808-9702-44b7-bcfa-56e8d02d3a2f)

As it seems, we have an issue with our DHCP config file and with our network interfaces files. Let's check these.
##### network interfaces
Let's first assign a static IP to our server.
The file to do so is located in the /etc/network.interfaces path. It handles all the networks connected to our VM's, so we'll use it to configure which interface will distribute the IP address to our client.
In our case, this interface is the **enp0s8** and here below is its configuration :

![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/5d2cf87c-0969-4486-b254-65cc8c156a0f)

We decided to attribute our network the address 192.168.0.16/28, so that we'd be able to distribute only 14 IP's (from 17 to 30). Since we're handling a small library's network, this should be sufficient for the current needs and the future changes.
Our server will get the static IP 192.168.0.17 so that our clients won't lose the access to it.
##### dhcpd.conf file
Now that our server has a static IP, let's handle the DHCP file so that our server know which address to assign.
The file to do so is located in the /etc/dhcp/dhcpd.conf path.
And in this file, this is how we attributed our DHCP range :

![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/82f7f881-5d4a-4090-ae5f-471f89a2bf33)

We also shouldn't forget to adapt the file located in /etc/defaul/isc-dhcp-server path, as it's the one we have to configure to tell our system which network interface shall distribute the DHCP request.
Here's how we configured it :
![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/0a5e930b-c96c-4f26-ba07-ff787ba389b7)

We can now see that out DHCP server is indeed well in place and did start :

![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/f9e5e707-5cb8-4a08-8ff8-8fff33cba731)

However, let's check if our client can indeed get its IP address from this server by changing the workstation's interface from enp0s3 (the VM one) to enp0s8 (the server one).

![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/18c83d6c-4a5d-4aff-8c93-605f2179eab1)

And it indeed does connect to our previously given subnet!

#### DNS via the bind9 service 📃 
Now that our DHCP server is up and running, let's concentrate on the bind9 DNS server. 
First, let's install it via this command :
```
sudo apt install bind9
```
Second, we'll just adapt the file located at /etc/bind/named.conf.options so that it forwards all DNS requests via the Google owned DNS :

![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/96d0e30f-de8a-4dbe-80e8-aeab23436737)

Third and finally, we can check if the client's DNS request work fine by using the "Dig" command on a random website. Why not try it on Becode's website and see if we get an answer ?
```
dig @192.168.0.17 becode.org
```

![Proof dns works](https://github.com/The-Bear50/Personal_Projects/assets/85135970/1bb40795-25b3-42c4-9c71-222362116dd0)

It returns us Becode's IP address as expected. 

#### HTTP and mariadb via GLPI 📊 

For this part, we maily followed this [french-speaking tutorial](https://www.it-connect.fr/installation-pas-a-pas-de-glpi-10-sur-debian-12/) as it was very helpful understanding the many steps this installation requires.

Obviously, not all information are the same so here are the ones we adapted for our own GLPI service :
- [ ] name of library : library_glpi
- [ ] user created : admin with password "MariaDB"
- [ ] personal domain created : support.library.be

Although this last one doesn't lead to our GLPI server, you can see below that the setup pretty much worked as we were able to reach our server and set it up via our local IP :

![proof GLPI works with IP address](https://github.com/The-Bear50/Personal_Projects/assets/85135970/cdc45edb-967c-4b9f-9055-df4ad0c8b9c9)
![proof GLPI works with IP address4](https://github.com/The-Bear50/Personal_Projects/assets/85135970/c0ebd59d-906c-4dd6-9a82-159a3a0ca070)

As you can see, and although it works, some issues are to be fixed such as :
- Some safety requirements not yet having been met (due to incapability of resolving it in time for this project)
- The domain name is, for now, useless as it doesn't lead to the service.

Nonetheless, it works !

#### The server is remotely manageable (SSH)
This was done during the installation of the Debian 12 CLI image, so no configuration was involved on the server side. The only thing necessary was to install the open-ssh client package on the client computer to ensure an SSH connection to the server.
This was the command used to install the client package on the workstation side :
```
sudo apt install openssh-client
```
![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/1752f81a-9555-4303-81f3-151a79ea0dc0)

and here it's shown connecting to our server (using the server's ip address given by us earlier)

![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/2784f8bc-96ff-40ef-a38d-d7664b8d4790)

![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/8956d4fe-828c-4934-bccc-915ec13abe4c)

## To do in the future 🚧 

I'm glad I could install all the above on my server, but you'll see that I miss some of the features that were asked about. The source of these absences is rooted in my current lack of knowledge and reflexes, thus leading me into losing time for this project. Here below are the features that I currently miss :

- [ ] The GLPI server can be accessed via the IP address but not the domain name. Some files on the client side need to be adapted for that. Current fixes haven't lead to success.
- [ ] The server is currently unprotected against attacks, so we'll need to set-up firewalls and other defense mechanisms.
- [ ] There is currently no backup of the server file, which is dangerous as any issues may lead to a total loss of data.

# Personal conclusion 🌻

I have to say this was a challenging project for someone pivoting into a cybersec career ! It was a good mix of very different topics I'm getting more knowledgeable in as time goes by, but it definitely showed me that there's still much to learn ahead of me. 

The 4 days we've had to plan this project were a bit short for me, but I'm sure that, as my experience increases, the time taken to set-up these kind of servers will decrease and I'll be able to put more of me into these projects rather than rely on the knowledge of others. I'm very fond of not reinventing the wheel, but I still crave to know intimately all the concepts I currently can only but grasp and implement.

For now, let's be happy about this new step into my new career !
