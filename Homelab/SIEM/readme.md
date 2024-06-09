# SIEM - Security Onion
Since I'd like to dig deeper into blue team solutions that collect, gather and present network traffic in a neat way, I'm interested in installing and configuring [Security Onion's OS](https://www.cisa.gov/resources-tools/services/security-onion) in my Proxmox instance to see what it looks like ! 
## Hardware requirements

The [official website](https://docs.securityonion.net/en/2.4/hardware.html) tells us that the least resource hungry version of SO is the "Standalone" version, so we'll take it into account when setting everything up:

![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/11b558da-a485-43f1-81a5-f39f6fdf1b68)

## VM creation and config

We'll add SO's ISO image to our server. Let's go to the "Local (Serveur)" section of Proxmox, then go to "Iso Images" and click on "Download from URL"; There, enter the [download URL]() provided by the official website and click on "Query URL".

This should fill all the info for you. Click then on "Download" and wait for it to finish

![image-1](https://github.com/The-Bear50/Personal_Projects/assets/85135970/b1638abe-129c-4f61-8ec6-fc97049e1dab)
![image-2](https://github.com/The-Bear50/Personal_Projects/assets/85135970/fcae0630-f4e7-465f-a0bb-7783a1c8802b)

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

![image-3](https://github.com/The-Bear50/Personal_Projects/assets/85135970/698ee0ed-4604-4a74-9692-4838f25c86da)

You can then create a new VM following the hardware requirements and the [Proxmox page on SO's website](https://docs.securityonion.net/en/2.4/proxmox.html#proxmox). I personally ended up with the below requirements :

![image-5](https://github.com/The-Bear50/Personal_Projects/assets/85135970/d5ccc85c-749b-46d9-8c7c-42ef045f24b8)

## OS installation

I won't detail the installation process here as the [official website](https://docs.securityonion.net/en/2.4/first-time-users.html) does it brilliantly.

The only thing I'd advise to go for when you launch the OS first <b>in case you get stuck after getting the message "reached target path unit"</b>, is to choose the below option as it's similar to the default one, but doesn't trigger any bug.

![image-6](https://github.com/The-Bear50/Personal_Projects/assets/85135970/f4d95b5c-a038-4d42-a6d0-6278de6d1041)

When it has finished installing, it'll reboot and prompt up the below screen :

![image-4](https://github.com/The-Bear50/Personal_Projects/assets/85135970/4ed2412a-5f5a-4325-bfdc-e87ec51e9cc3)

Follow all the instructions from Security Onion's first time users' page and it should be fine !
The only changed I made, as the below summary shows, is to adapt the DNS servers to only allow the one from Quad9 (9.9.9.9)

![image-7](https://github.com/The-Bear50/Personal_Projects/assets/85135970/96daf6e5-f966-411b-9359-837b5f4040e1)

It's going to take a while to install everything so go for a walk or read something!

When over, this is the screen you'll get :

![image-8](https://github.com/The-Bear50/Personal_Projects/assets/85135970/8e11ba97-4c1a-44e0-a052-50061d132432)

## Web UI 
Following the above instruction, we visit our web UI through the previously configured IP :

![image-9](https://github.com/The-Bear50/Personal_Projects/assets/85135970/f792170a-2c22-4994-b7f1-3cfb2ce32076)

Following the instructions, we're going to the "grid" section to see if everything is setup properly (which it is) :

![image-10](https://github.com/The-Bear50/Personal_Projects/assets/85135970/f78306d1-9b8e-418d-8da1-8554b71227e5)

## Conclusion

And here it is for now about this SIEM installation ! The following steps will lead us to check the logs, ensure they're properly extracted and analyzed, look at the hosts we want to watch and configure them properly. All this while ensuring our OS can manage the network weight.
