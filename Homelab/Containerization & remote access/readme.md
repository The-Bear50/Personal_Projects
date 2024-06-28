# Remote access through containerization in Proxmox
## Scope of project
Since I won't be always connected to my home network but still may want to access its resources or check it in case of any issues, I'll install an OpenVPN container in my Proxmox server to ensure that I can reach my server safely and securely without anyone else getting access to it.
# Walkthrough
## Creating the LXC
In your local section of your node (remember : the local section is for installing the VM and CT templates, whereas the Local-LVM disk will be used for all your VM/CT files and internal disks), 
go to "CT templates" and then click on "Templates :

![image-15](https://github.com/The-Bear50/Personal_Projects/assets/85135970/486c4a1b-bb89-4a4a-bae5-4728af1bfea4)

In the list, choose then the template that you'd like. For OpenVPN, I'll follow the [official specs page of OpenVPN](https://openvpn.net/as-docs/system-requirements.html#hardware-requirements) and I'll download the Ubutntu 22.04 template.

After this, click on "Create CT" in the top right corner.

I'll give my container an ID, a name and a secure password. I'll give the 200 ID for this one as I'd like to differentiate between VM's (1XX) and containers (2XX):

![image-17](https://github.com/The-Bear50/Personal_Projects/assets/85135970/65415e94-37d7-485b-9d69-b035f8a23cf9)

When done, click on "Next" and choose then your template. I'll use the one I just downloaded :

![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/5b99459b-710f-45b1-bc46-8f7746730b91)

For the rest, I'm going to go with the proposed default specs as this is only going to help me manage my server from afar, so we have :
- 16 GB of SSD
- 2 CPU core
- 1024 MB of RAM

As for the IPV4 address, I'll give the last usable address of my network to it so as to remember the IP more easily.

![image-1](https://github.com/The-Bear50/Personal_Projects/assets/85135970/6b864eeb-8980-4ca6-83ad-a98765b11c3c)

Here's the final structure of this container : 

![image-2](https://github.com/The-Bear50/Personal_Projects/assets/85135970/d310ef14-b99b-4c27-a24d-a1a7809eee6f)

## Configuring the OpenVPN container

Start your newly created container and enter console mode. When done, login as root and use your chose password during the installation process :

![image-23](https://github.com/The-Bear50/Personal_Projects/assets/85135970/8d5e66f0-a8cf-4168-a43d-5ac7e75ac773)

Let's un the following command to ensure that our container is fully updated before handling OpenVPN :

````
sudo apt update && apt upgrade -y
````

When done, run the following commands to install a Certificate Authority (CA), the basic network tools of Ubuntu and GnuPG for encrypting our connection 

````
apt install ca-certificates wget net-tools gnupg
````

After this, launch the below command to add the OpenVPN repository to your list of repositories so it'll be taken into account when updating the system

````
sudo wget -qO - https://as-repository.openvpn.net/as-repo-public.gpg | apt-key add -
````

![3-1](https://github.com/The-Bear50/Personal_Projects/assets/85135970/c5957568-55c6-4d0f-a843-d1940568bdcf)

We're getting an interesting message here. Although it seems everything worked, we're being told that the "apt-key" command is going to be deprecated.

After some [researching](https://itsfoss.com/apt-key-deprecated/), it looks like the "apt-key" command has some flaws regarding the way it adds the repository to our machine. It trusts completely the added repo without checking what files come from which repository. This can lead to some file being trusted while they're not originating from the right repo.

Let's fix this before moving on, since we don't want our future updates to be possibly retrieved from a shady repository. We'll follow the [official tutorial](https://as-portal.openvpn.com/instructions/ubuntu/installation) of OpenVPN regarding this.


````
wget https://as-repository.openvpn.net/as-repo-public.asc -qO /etc/apt/trusted.gpg.d/as-repository.asc
````
````
echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/as-repository.asc] http://as-repository.openvpn.net/as/debian jammy main">/etc/apt/sources.list.d/openvpn-as-repo.list
````

Do not forget to dearmor your .asc public key so that it's readable for your system.

````
gpg --dearmor as-repository.asc
````

![image-7](https://github.com/The-Bear50/Personal_Projects/assets/85135970/1c55aa0a-18f3-4213-8ad7-9a7843822a3c)

As you can see below, the update and upgrade command don't trigger any error now as they're looking after the proper repo linked to the correct SHA key.

![image-3](https://github.com/The-Bear50/Personal_Projects/assets/85135970/2f0fe7ab-900e-463f-995b-3bd48630db9f)

Moving on from this, we'll now finally be able to install OpenVPN access server per se :

````
sudo apt install openvpn-as
````

This goes on for a while, and when it's done, it indicates us on which IP address we can continue with the configuration !

![image-8](https://github.com/The-Bear50/Personal_Projects/assets/85135970/aa3ebdb3-65f0-48a4-adc5-5e8c8c0619e5)

(Password will have changed by the time you read this, you cheeky people)

## Creation of our user 

Let's go on the mentionned IP address to add our user.

![image-9](https://github.com/The-Bear50/Personal_Projects/assets/85135970/b0b5a0b6-2610-4396-9406-9ffb7370df40)

Don't pay attention to this message and move on.

You'll get to the main login page where you can use the previously provided credentials. When done, you can accept the user agreement and get to the admin page !

![image-10](https://github.com/The-Bear50/Personal_Projects/assets/85135970/dbdd5e1c-db4f-417c-a4ce-efcbc6ef7022)

There, go change your admin profile password by going to the below sections.

![image-11](https://github.com/The-Bear50/Personal_Projects/assets/85135970/991c5829-d04e-49ed-90a1-c73a66b4676a)

When done, create a new user for the host that'll have to connect from afar. Use the same method :

![image-12](https://github.com/The-Bear50/Personal_Projects/assets/85135970/6afe667f-bf5a-4f3b-a87f-9939ffbc95ff)

### Errors when trying to launch your server

1. Tun file not found

Now, if you followed everything until here, you'll surely end up with errors when trying to launch your system because it tells you that it can't find the "/dev/net/tun" file it needs to run.

![12-1](https://github.com/The-Bear50/Personal_Projects/assets/85135970/27f6b76d-a874-48a9-b50b-9ed6b4e2c30f)

If you were smarter than me, you already read [Proxmox's official tutorial](https://pve.proxmox.com/wiki/OpenVPN_in_LXC) and so you already ensured that Proxmox's tun file is funneled properly to your container by adapting its ".conf" file and changing the ownership of that tun file.

BUT, if you actually did it and still get errors and end up with an unbootable container, here's what you should do : instead of writing the proposed Proxmox's text (in the red box below) in the .conf file of your container, write the one above (in green)

![image-14-1](https://github.com/The-Bear50/Personal_Projects/assets/85135970/0c87852c-eef4-4077-8f46-5d1582c55fdd)

When done so on my side, the server was running without issue afterwards

![image-16](https://github.com/The-Bear50/Personal_Projects/assets/85135970/2a2c71e6-9ddf-4e98-874c-0eca4ce350cd)

2. Home network's public IP address

For your remote connection to exist, you need your remote host to connect via your home network's **public** IP. This is by default not available in Belgium on your router, so you may need to ask to your ISP to unlock this.

Since I was a client of Zuny, I found out that merely asking them via Whatsapp about unlocking this public IP for my server purposes was enough. In 30 minutes, I got it and could then adapt my OpenVPN's IP address to match it.

Also, do not forget to forward the relevant port on your router so that OpenVPN gets access to your home network.

![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/ab0d4cea-a2fd-4438-b018-93146b7ecc3b)


![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/2893800d-a7d9-4cc9-b86f-2e169fed47e3)


## Installation of the OpenVPN client on the remote host

Now, obviously, we need to ensure our remote host can connect to the VPN, and therefore to the server. This can easily be done by going into "User profiles" and then "New profile" under the name of your user.

![image-14](https://github.com/The-Bear50/Personal_Projects/assets/85135970/32e59f2b-c58c-41a8-9280-0a9f72ff72c4)

Send the ".ovpn" file that the platform will grant you to your remote host. When done, the user can open that file via the OpenVPN application and enter the password.

For the purpose of this demonstration, I'm showing you below the two IP adresses I had before (the top one) and after (the bottom one) switchin my PC's connection from my home wifi to my phone 4G.

![448752500_341832575624573_4086815004469140222_n](https://github.com/The-Bear50/Personal_Projects/assets/85135970/01587883-75da-4b19-a73f-7a613f484a2f)

So, while being connected to my phone but **without** being linked to the VPN, connecting to my Proxmox server was, of course, unsuccessful.

![448555961_352071201032415_276736964963003859_n](https://github.com/The-Bear50/Personal_Projects/assets/85135970/d7c56c41-a660-40b3-a0b5-d7a2bb83cc05)

But after connecting to it, as you can see below, I was able to reach my server from my phone's 4G !

![448540135_459337093717206_4863504970462108589_n](https://github.com/The-Bear50/Personal_Projects/assets/85135970/9a6239ac-0a97-4a99-b600-41446ba38d68)







