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
- Debian 12.5
- 4 gb memory
- 2 processors
- 40 gb of space on the virtual HDD

### Walkthrough of the requirements' installation
#### LibreOffice
This is installed by default on the GUI version of Debian 12.5, so nothing to do here.
![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/7dabad6f-58e6-427e-8300-8b2f4923d17c)
#### Gimp
#### Mullvad browser
#### automatic addressing
#### /home folder is located on a separate partition, same disk 

## Server side

Specs : 
- Debian 12.5
- 4 gb memory
- 2 processors
- 40 gb of space on the virtual HDD
- 
