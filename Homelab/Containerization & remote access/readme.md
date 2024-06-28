# Remote access through containerization in Proxmox
## Scope of project
Since I won't be always connected to my home network but still may want to access its resources or check it in case of any issues, I'll install an OpenVPN container in my Proxmox server to ensure that I can reach my server safely and securely without anyone else getting access to it.
# Walkthrough
## Creating the LXC
In your local section of your node (remember : the local section is for installing the VM and CT templates, whereas the Local-LVM disk will be used for all your VM/CT files and internal disks), 
go to "CT templates" and then click on "Templates :

![alt text](image-15.png)

In the list, choose then the template that you'd like. For OpenVPN, I'll follow the [official specs page of OpenVPN](https://openvpn.net/as-docs/system-requirements.html#hardware-requirements) and I'll download the Ubutntu 22.04 template.

After this, click on "Create CT" in the top right corner.

I'll give my container an ID, a name and a secure password. I'll give the 200 ID for this one as I'd like to differentiate between VM's (1XX) and containers (2XX):

![alt text](image-17.png)

When done, click on "Next" and choose then your template. I'll use the one I just downloaded :

![alt text](image.png)

For the rest, I'm going to go with the proposed default specs as this is only going to help me manage my server from afar, so we have :
- 16 GB of SSD
- 2 CPU core
- 1024 MB of RAM

As for the IPV4 address, I'll give the last usable address of my network to it so as to remember the IP more easily.

![alt text](image-1.png)

Here's the final structure of this container : 

![alt text](image-2.png)

## Configuring the OpenVPN container

Start your newly created container and enter console mode. When done, login as root and use your chose password during the installation process :

![alt text](image-23.png)

Let's un the following command to ensure that our container is fully updated before handling OpenVPN :

'''
sudo apt update && apt upgrade -y
'''

When done, run the following commands to install a Certificate Authority (CA), the basic network tools of Ubuntu and GnuPG for encrypting our connection 

'''
apt install ca-certificates wget net-tools gnupg
'''

After this, launch the below command to add the OpenVPN repository to your list of repositories so it'll be taken into account when updating the system

'''
sudo wget -qO - https://as-repository.openvpn.net/as-repo-public.gpg | apt-key add -
'''

![alt text](3-1.png)

We're getting an interesting message here. Although it seems everything worked, we're being told that the "apt-key" command is going to be deprecated.

After some [researching](https://itsfoss.com/apt-key-deprecated/), it looks like the "apt-key" command has some flaws regarding the way it adds the repository to our machine. It trusts completely the added repo without checking what files come from which repository. This can lead to some file being trusted while they're not originating from the right repo.

Let's fix this before moving on, since we don't want our future updates to be possibly retrieved from a shady repository. We'll follow the [official tutorial](https://as-portal.openvpn.com/instructions/ubuntu/installation) of OpenVPN regarding this.


'''
wget https://as-repository.openvpn.net/as-repo-public.asc -qO /etc/apt/trusted.gpg.d/as-repository.asc
'''
'''
echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/as-repository.asc] http://as-repository.openvpn.net/as/debian jammy main">/etc/apt/sources.list.d/openvpn-as-repo.list
'''

Do not forget to dearmor your .asc public key so that it's readable for your system.

'''
gpg --dearmor as-repository.asc
'''

![alt text](image-7.png)

As you can see below, the update and upgrade command don't trigger any error now as they're looking after the proper repo linked to the correct SHA key.

![alt text](image-3.png)

Moving on from this, we'll now finally be able to install OpenVPN access server per se :

'''
sudo apt install openvpn-as
'''

This goes on for a while, and when it's done, it indicates us on which IP address we can continue with the configuration !

![alt text](image-8.png)

(Password will have changed by the time you read this, you cheeky people)

## Creation of our user 

Let's go on the mentionned IP address to add our user.

![alt text](image-9.png)

Don't pay attention to this message and move on.

You'll get to the main login page where you can use the previously provided credentials. When done, you can accept the user agreement and get to the admin page !

![alt text](image-10.png)

There, go change your admin profile password by going to the below sections.

![alt text](image-11.png)

When done, create a new user for the host that'll have to connect from afar. Use the same method :

![alt text](image-12.png)

### Errors when trying to launch your server
Now, if you followed everything until here, you'll surely end up with errors when trying to launch your system because it tells you that it can't find the "/dev/net/tun" file it needs to run.

![alt text](12-1.png)

If you were smarter than me, you already read [Proxmox's official tutorial](https://pve.proxmox.com/wiki/OpenVPN_in_LXC) and so you already ensured that Proxmox's tun file is funneled properly to your container by adapting its ".conf" file and changing the ownership of that tun file.

BUT, if you actually did it and still get errors and end up with an unbootable container, here's what you should do : instead of writing the proposed Proxmox's text (in the red box below) in the .conf file of your container, write the one above (in green)

![alt text](image-14-1.png)

When done so on my side, the server was running without issue afterwards

![alt text](image-16.png)

## Installation of the OpenVPN client on the remote host



![alt text](image-14.png)


