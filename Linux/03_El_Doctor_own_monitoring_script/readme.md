# El Doctor - A monitoring tool to rule them all! 📡

- Module: Scripting
- Competence: is able to write a custom script to monitor machines
- Type of Challenge: Consolidation
- Duration: 3 day
- Deadline: 12/04/2024
- Participants: : solo

## The Mission 🏃

[Here](https://github.com/becodeorg/BXL-k4MK4r-2/blob/main/content/02-Linux/09-Projects/03-El_Doctor.md) is the summarized scope of this project.

## Personal setup 💻

What I'd like for this monitoring script to be displaying when ran, and sent via mail, is the following :

- Greeting message + mention of anything weird having been recorded.
- Specs of the machine monitored :
    - CPU.
    - RAM.
    - Disk space.
    - Network used.
    - Number of users connected and their names.
    - Uptime
- Current state of these specs.
- Mention of the hour as of which the next monitoring will take place.

## Things to be done 📎

- Writing a bash script triggering all monitoring
- Testing it
- Ensuring it is sent by mail
- Writing a cron job so that the moniroting script gets automated

### Writing the script ✍️

Since I'm not yet very competent in writing scripts, I'll get some help from the internet and our friend ChatGPT to get the first structure of our bash codes.
After tweaking it a bit to my own needs, I got five different scripts that'll trigger every command I need :
- [CPU script](https://github.com/The-Bear50/Personal_Projects/blob/main/Linux/03_El_Doctor_own_monitoring_script/Scripts/CPU_mpsat_monitoring.sh)
- [HDD I/O script](https://github.com/The-Bear50/Personal_Projects/blob/main/Linux/03_El_Doctor_own_monitoring_script/Scripts/Disk_usage_IO_monitoring.sh)
- [Network usage script](https://github.com/The-Bear50/Personal_Projects/blob/main/Linux/03_El_Doctor_own_monitoring_script/Scripts/iftop_network_monitoring.sh)
- [Power consumption script](https://github.com/The-Bear50/Personal_Projects/blob/main/Linux/03_El_Doctor_own_monitoring_script/Scripts/power_consumption_monitoring.sh)
- [Memory usage script](https://github.com/The-Bear50/Personal_Projects/blob/main/Linux/03_El_Doctor_own_monitoring_script/Scripts/top_memory_monitoring.sh)

### Testing the script 🧪

Running them works like a charm, but obviously the mail part doesn't work yet as we'll have to set up the "mailutils" and the "msmtp" packages from Debian properly to fix that error code :

![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/0c485086-fd96-42fe-b2ec-c3f1a23474cb)

Here is an example of one of the outputs in text.

![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/43e0c7ae-d84d-4752-93ac-4433b7ce95b1)

And here it is in CSV.

![image](https://github.com/The-Bear50/Personal_Projects/assets/85135970/b0c0ccf8-1a48-4b43-897c-dae7363990f3)

Obviously they'll need to be adapted so that the columns would fit with their numbers below, but it still displays the information we'd like to see.

### Sending the script 📫

This is the part that still needs to be tackled has I can't get rid of error 78 when trying to send via the "mail" command all my scripts. Seems to be an issue with the configuration file, but can't yet put my finger on it. To be continued !

### Automating the script ⏰

A cron job has been set up for this script to run every hour. It was configure by going into the // file and entering the following configuration :

````
crontab -e
0 * * * * /bin/bash /home/library/Linux/Moniroting/scripts/master_monitoring.sh
````
### To do 🚧
- Fix the mail sending issue and ensure the mail contains all the important info at a glance
- Adapt the CSV files so that they're nicer to read

### Personal Conclusion 🌻

This was a though challenge for me knowing that I have yet to develop my script writing skills and also my knowledge about how to send mail via the CLI interface.
I really want to make it work so I'll do my best to come back to this project and update it with my newest findings ! 🤞
