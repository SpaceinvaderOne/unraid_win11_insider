# unraid_win11_insider
Download Windows 11 via UUP files from Windows Update servers for Unraid VMS

This is a container to be run on an Unraid server. It will help with the setup of a Windows 11 insider build VM.
To use this please install through Unraid's community applications
You can see the template here https://raw.githubusercontent.com/SpaceinvaderOne/Docker-Templates-Unraid/master/spaceinvaderone/windows11_uupdump.xml

Basic usage

This container uses https://uupdump.net/ buid scripts to Download UUP files from Windows Update servers with ease. 
By default this container will a download windows 11 pro english iso image and place it in the Unraid iso share. So just run the container and it will download and create the iso and place it in the Unraid isos share automatically

Advanced Usuage

However you can download any image from the Windows Update servers by using any build script from https://uupdump.net/.
Just download the build package and unzip it and place it in the custom folder in the containers appdata folder. 
Then set the variable in the template from defualt to custom. And run the container and the iso will be created
