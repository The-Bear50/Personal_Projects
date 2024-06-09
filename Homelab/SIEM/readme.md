# SIEM - Security Onion
Since I'd like to dig deeper into blue team solutions that collect, gather and present network traffic in a neat way, I'm interested in installing and configuring [Security Onion's OS](https://www.cisa.gov/resources-tools/services/security-onion) in my Proxmox instance to see what it looks like ! 
## Hardware requirements

The [official website](https://docs.securityonion.net/en/2.4/hardware.html) tells us that the least resource hungry version of SO is the "Standalone" version, so we'll take it into account when setting everything up:

[![alt text](image-1.png)](https://github.com/The-Bear50/Personal_Projects/blob/main/Homelab/SIEM/Assets/image-1.png)

## VM creation and config

We'll add SO's ISO image to our server. Let's go to the "Local (Serveur)" section of Proxmox, then go to "Iso Images" and click on "Download from URL"; There, enter the [download URL]() provided by the official website and click on "Query URL".

This should fill all the info for you. Click then on "Download" and wait for it to finish

![alt text](image-1-2.png)
![alt text](image-2.png)

When it's done, we'll verify the ISO to ensure it's indeed the right one. To do so, we'll import [Security Onion's signing key](https://github.com/Security-Onion-Solutions/securityonion/blob/2.4/main/DOWNLOAD_AND_VERIFY_ISO.md) in our server and use it to check the ISO.

Open the Server's shell command and go to folder /var/lib/vz/template/iso. When there :

- Download and import the signing key:  
```
wget https://raw.githubusercontent.com/Security-Onion-Solutions/securityonion/2.4/main/KEYS -O - | gpg --import -  
```

- Download the signature file for the ISO:  
```
wget https://github.com/Security-Onion-Solutions/securityonion/raw/2.4/main/sigs/securityonion-2.4.70-20240529.iso.sig
```

Finally, verify the downloaded ISO image using the signature file:  
```
gpg --verify securityonion-2.4.70-20240529.iso.sig securityonion-2.4.70-20240529.iso
```

If everything goes right, this is what you should get as an answer :

![alt text](image-3.png)

You can then create a new VM following the hardware requirements and the [Proxmox page on SO's website](https://docs.securityonion.net/en/2.4/proxmox.html#proxmox). I personally ended up with the below requirements :

![alt text](image-5.png)

## OS installation

I won't detail the installation process here as the [official website](https://docs.securityonion.net/en/2.4/first-time-users.html) does it brilliantly.

The only thing I'd advise to go for when you launch the OS first <b>in case you get stuck after getting the message "reached target path unit"</b>, is to choose the below option as it's similar to the default one, but doesn't trigger any bug.

![alt text](image-6.png)

When it has finished installing, it'll reboot and prompt up the below screen :

![alt text](image-4.png)

Follow all the instructions from Security Onion's first time users' page and it should be fine !
The only changed I made, as the below summary shows, is to adapt the DNS servers to only allow the one from Quad9 (9.9.9.9)

![alt text](image-7.png)

It's going to take a while to install everything so go for a walk or read something!

When over, this is the screen you'll get :

![alt text](image-8.png)

## Web UI 
Following the above instruction, we visit our web UI through the previously configured IP :

![alt text](image-9.png)

Following the instructions, we're going to the "grid" section to see if everything is setup properly (which it is) :

![alt text](image-10.png)


## Conclusion

And here it is for now about this SIEM installation ! The following steps will lead us to check the logs, ensure they're properly extracted and analyzed, look at the hosts we want to watch and configure them properly. All this while ensuring our OS can manage the network weight.
