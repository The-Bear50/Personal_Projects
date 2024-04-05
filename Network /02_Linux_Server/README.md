# Project context 
The local library in your little town has no funding for Windows licenses so the director is considering Linux. Some users are sceptical and ask for a demo. The local IT company where you work is taking up the project and you are in charge of setting up a server and a workstation.
To demonstrate this setup, you will use virtual machines and an internal virtual network (your DHCP must not interfere with the LAN).

You may propose any additional functionality you consider interesting.

## Must Have

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

## How will we do this?

We'll install two virtual machines on Virtualbox so that we can simulate this small local network. Both machines will have two ethernet adapters so that we can ensure they can download their packages from the internet, BUT so that we can still check if our local network between them works.

# Setup
## Client side (workstation)

Specs : 
- Debian 12.5 as a Graphical installation
- 4 gb memory
- 2 processors
- 40 gb of space on the virtual HDD
- The "nala" package manager will be installed and used instrad of the "apt" package manager one, as it's a nicer interface for installing applications via the CLI.
- Username : "library"; password : "library"
- Root password : "library"
- Language : French (so that our keyboard keys match our input)

Although it isn't safe for a real-life project, we've set both user and root password to "library", and our user name to "library" as well so that any installation process would be easy. Proper safety feature would be to set a passphrase password to the root user, therefore ensuring our library worker wouldn't get admin access to his/her system.

### Walkthrough of the requirements' installation
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

#### The /home folder is located on a separate partition 
This was done during the installation of the VM, as it then asked us if we wanted to partition our disk. Since we answered yes, it then asked us, among multiple choices, if our /home partition had to be separated. To which we agreed.
The result is then displayed via the terminal.
![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/a3a0bbd8-46f2-48a3-81d1-8625c1dcf5de)








## Server side

Specs : 
- Debian 12.5 as a CLI installation
- 4 gb memory
- 2 processors
- 40 gb of space on the virtual HDD
- Username : "server"; password : "server"
- Root password : "server"

Just like for the client, we'd obviously advise to change these passwords for a real-life project as they're not safe.

### Walkthrough of the requirements' installation
#### SSH connection to our server
Since this'll make our job easier as we'll be able to copy-paste commands to install our services, we'll install an SSH solution on the server so we can get access to it from our computer.
[Here](https://phoenixnap.com/kb/how-to-enable-ssh-on-debian) are the instructions we followed.

Of course, take into account that our own IP address was different as shown here below :
![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/49fc82a2-7e48-4cca-ad8f-7c999de746f0)

#### DHCP via the isc-dhcp-server service
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
The file to do so is located in the/etc/



#### DNS via the bind9 service
#### HTTP and mariadb via GLPI
    - **Required**
        1. Weekly backup the configuration files for each service into one single compressed archive
        2. The server is remotely manageable (SSH)
    - **Optional**
        1. Backups are placed on a partition located on  separate disk, this partition must be mounted for the backup, then unmounted
