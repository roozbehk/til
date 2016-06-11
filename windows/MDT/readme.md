### Why use MDT Lite Touch to create reference images

You can create reference images for Configuration Manager in Configuration Manager, but in general we recommend creating them in MDT Lite Touch for the following reasons:

In a deployment project, it is typically much faster to create a reference image using MDT Lite Touch than Configuration Manager.
You can use the same image for every type of operating system deployment - Microsoft Virtual Desktop Infrastructure (VDI), Microsoft System Center 2012 R2 Virtual Machine Manager (SCVMM), MDT, Configuration Manager, Windows Deployment Services (WDS), and more.
Microsoft System Center 2012 R2 performs deployment in the LocalSystem context. This means that you cannot configure the Administrator account with all of the settings that you would like to be included in the image. MDT runs in the context of the Local Administrator, which means you can configure the look and feel of the configuration and then use the CopyProfile functionality to copy these changes to the default user during deployment.
The Configuration Manager task sequence does not suppress user interface interaction.
MDT Lite Touch supports a Suspend action that allows for reboots, which is useful when you need to perform a manual installation or check the reference image before it is automatically captured.
MDT Lite Touch does not require any infrastructure and is easy to delegate.

Blogs:

Updated Powershell scripts for Windows ADK 10 and MDT 2013 update 1 Build 8298 http://renshollanders.nl/2015/09/mdt-updated-powershell-scripts-for-windows-adk-10-and-mdt-2013-update-1-build-8298/

Configuring MDT 2013 Deployment Share settings via PowerShell http://deploymentresearch.com/Research/Post/403/Configuring-MDT-2013-Deployment-Share-settings-via-PowerShell

http://henkhoogendoorn.blogspot.com/2015/12/how-to-remove-windows-and-office.html


http://deploymentresearch.com/Research/Post/521/Back-to-Basics-Building-a-Windows-7-SP1-Reference-Image-using-MDT-2013-Update-2

OS Deployment, Virtualization
https://deploymentbunny.com/

Making reference images 8.1: https://www.youtube.com/watch?v=9akpHwJS5bg

MDT Deplyment Advanced Topics : https://www.youtube.com/watch?v=wPkWytKmVqM

ZoomIT: https://live.sysinternals.com/

SCU 2014- Kent Agerlund https://www.youtube.com/watch?v=9hDFqcPjjSA


