# Homelab :microscope:
## Why having a homelab :grey_question:
The reason I'm getting interested in homelabing is, unsurprinsingly, certainly for the same reasons many others do : testing projects I read about on the internet. It seems like the funniest way to try stuff one's stumbles upon while browsing, and in my case it also is a way to practice further the theory I learn on a day-to-day basis during my bootcamp and my researches.

Without further ado, let's summarize what this project currently will focus on.
## Scope of the project :mag:
Additional features may be added as time goes by, but here below are the reasons that originally came to mind when getting into this project :
- Getting a <ins>media server</ins> : this will be done by setting up a [Jellyfin](https://jellyfin.org/) environment. :tv:
- Having an <ins>ad blocker</ins> on the DNS level. In this case, we'll dig deeper into the [DNSMasq](https://github.com/alblue/dnsmasq-example?tab=readme-ov-file) feature. :mask:
- Setting up a <ins>SIEM/XDR solution</ins> to scan my network and act on any weird actions (although it'll most certainly be mainly used so that I can get better acquainted to these solutions). [Wazuh](https://wazuh.com/) is our winner here. :detective:
- <ins>Virtualizing any machines</ins> needed for other projects/interests. This'll be done by setting up [Proxmox](https://www.proxmox.com/en/) as a VE on my machine. I'll get acquainted to [Docker](https://www.docker.com/) as well during the process since I'd like to make the system as ressource-efficient as possible. :orange_square: :whale2:
- Ability to <ins>access the server from outside</ins> via the [OpenVPN](https://openvpn.net/) solution. :motorway:
- <ins>Monitoring the server's hardware</ins> load with InfluxDB and [Grafana](https://www.linuxsysadmins.com/monitoring-proxmox-with-grafana/) :traffic_light:

## Walkthrough of the project :walking:
- [Specs of the server](https://github.com/The-Bear50/Personal_Projects/blob/main/Homelab/Specs/readme.md)
- [Proxmox and virtualization](https://github.com/The-Bear50/Personal_Projects/blob/main/Homelab/Proxmox%20and%20Virtualization/readme.md)
- [Proxmox templates and clones](https://github.com/The-Bear50/Personal_Projects/blob/main/Homelab/Proxmox%20templates%20%26%20clones/readme.md)
- Containerization and remote access
- Monitoring the server
- SIEM/XDR solution
