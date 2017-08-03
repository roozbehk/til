Videos & Extra Content
How to Debug missing Drivers in MDT Litetouch

How to find the right MDT log files (bdd.log/smsts.log) to debug problems.

How to debug problems in Windows Setup (Panther)

Getting Started
What is MDT?

MDT is a product made by Microsoft to assist in the Deployment of Windows. It sits on top of other Microsoft technologies and tools like the WAIK/ADK, USMT, PXE/WDS, WSIM, Windows OOBE setup, and System Center Configuration Manager, and provides a single interface and environment for these tools. It’s fully supported by Microsoft, and has a well-established community of IT Professionals that use it.

What is the current version of MDT?

The current version is called "MDT version 8443" (MDT no longer has a year in the name like 2012 or 2013), and supports deployments of Windows 7 through Windows 10, and Windows Sever 2008 R2 through Windows Server 2016, and Configuration Manager 2012 and newer.  
Link: https://www.microsoft.com/en-us/download/details.aspx?id=54259

Previous versions include: 
"MDT 2013 Update 2" Build 6.3.8330.0
"MDT 2013 Update 1" Build 6.3.8298.0
"MDT 2013" Build 6.2.5019.0.

Where can purchase MDT?

MDT is available for FREE!  Download from: http://www.microsoft.com/deployment

How do I install MDT

There is a MDT package definition found on http://chocolatey.org, meaning you can use the built in Package Management functions found in Windows 10, Windows Server 2016, and WMF 5.0 to install.

Simply run these two steps in an elevated PowerShell window:  

Set-ExecutionPolicy Bypass Process
Install-Package MDT -provider Chocolatey -Force -ForceBootStrap 
Why would I use SCCM if MDT is free? Why use MDT if I already have SCCM?

MDT is a light weight Task Sequencing environment, it can deploy windows, or other simple tasks. Configuration Manager is a complete management system for your clients. Operating System Deployment (OSD), is only one of the many tasks that SCCM can do. Additionally, MDT has several “enhancements” to the stock Configuration Manager environment. If you are experienced with the standard MDT LiteTouch Task Sequence then the MDT/SCCM ZeroTouch Task Sequence will be easy.

What is LTI/ZTI/UDI?

MDT has several ways in which you can deploy images:

LiteTouch (LTI) is the term used to describe the MDT deployment process from the user’s perspective where there is small amount of user interaction at the start, and the remainder of the process is automated. (Confusingly…) MDT LTI process can be fully automated (skipping the wizards) to behave like a ZeroTouch process.
ZeroTouch (ZTI) is the term used to describe a Configuration Manager (SCCM) deployment with MDT extensions. From the user’s perspective, the procees is fully automated (Zero Touching). (Confusingly…) MDT ZTI can be made to prompt the user for information through UDI.
User Driven Installation (UDI) is a User Interface toolkit included in MDT that can be added to the Configuration Manager (SCCM) OSD process.
HeavyTouch (not a common term) can be used to describe the full Windows OOBE (Out of Box Experience), with no MDT or SCCM additions.
Where can I find out more information on MDT?

MDT itself actually has some great documentation. Variables are defined, all scripts are listed, and includes several walk through guides. Take a look.
There are several books on MDT deployment (Internet search for: MDT Book).
Several companies provide training sessions for MDT, SCCM and more.
MDT is always covered at the big Microsoft IT Conferences for Windows like TechEd.
Most Windows Desktop Deployment Consultants will be familiar with MDT and SCCM, including Microsoft’s own Consulting Group.
There are also tools and (hydration) kits available to quickly build out MDT evaluation environments. (Search for: Windows POC Kit)
Additionally, this forum is a great place to ask questions and get involved.
Forum guidelines 

Be Nice. Help out. Remember, there are always new people here who need help getting started.

What is cloning? What are Images? What is SysPrep?

Starting with Windows Vista, Microsoft has been moving towards the common industry model of disk imaging. That means once a machine has been setup into a desired “golden” state ( Applications Installed, Files Copied, Settings Configured ), the disk is copied to an archive file (disk image) so it can be applied to other machines (cloned).  Of course if you were to take a hard disk from one machine to another it shouldn’t work, the computer name needs to change, device drivers need to be re-enumerated, and the OS need to verify the hardware for licensing. The official way to prepare a machine for cloning is to run the SysPrep.exe tool just before the capture or move. Images are stored in several archive files used by Microsoft: *.wim files are compressed archives used by the Retail Windows Installation DVD’s, *.vhd/*.vhdx files are a generic container used by Hyper-V to emulate a physical disk.

How many times can I SysPrep the same machine (image)?

For Windows Vista and above: Three.

In Windows XP, it was common to take an OS image, install new applications, apply patches, sysprep, and re-use. Then when new applications and patches came out, you would take the latest OS image, and repeat the process. A Windows XP image may have been syspreped dozens of times. Over and over again.

However this image (un)management model was broken in Windows Vista, you could only sysprep a machine a maximum of three times (due to licensing changes). MDT has become a popular alternative to create images:

Add all of your Applications to the MDT console (with silent install switches)
Add any *.reg (registry modifications)
Create a create a task sequence with the Windows “retail” DVD image or Volume License (VL) files directly from Microsoft.
Then run the Task Sequence on a blank virtual machine, and export the captured result back to the MDT server.
MDT can even contact the Windows Update Service to download all the latest patches for your operating system.
If you are able to automate your application installs and registry settings, you have a consistent, repeatable imaging process. When Microsoft comes out with new critical patches, all you need to do is re-run the automated install in your virtual machine. Easy!

What are Fat Images? What are Thin Images? Hybrid?

MDT can be used in two different scenarios, Imaging and Deployment.

Imaging is the process of creating a new *.wim file that contains common Applications, Settings (and sometimes common Drivers). MDT can install the OS, Applications, Registry Settings, Patch using Windows Update, Sysprep, and save the contents to a single *.wim file in a single automated process.
Deployment is where MDT or SCCM can install a retail *.wim file or use a captured *.wim file to install on the end user’s machine. MDT can also install additional Applications, Configuration Settings, Migrate User Files and Settings, Drivers and more.
Should an Application be installed into the core image, or be installed at deployment? Examples:

Fat - If you have an environment where all the machines are identical (hardware, applications and setting), then a Fat Image could be optimal. Very little (or nothing) is done at deploy time.
Thin - If you have an environment where the machines are all different (hardware, applications, and settings), then it would be best to keep the core image as small (or thin) as possible, and perform an intelligent job of installing the required applications, settings and drivers per machine. A very thin image could be one that only contains Microsoft Hotfix patches.
How do I make registry settings I set in HKEY_CURRENT_USER available after I Sysprep?

When you make changes to the HKEY_CURRENT_USER registry key during your task sequence in MDT, it only makes changes for the local “Administrator” account. When you sysprep, by default those changes are discarded. It is possible to tell sysprep to make the local “Administrator” account the default user profile using CopyProfile. Check out these excellent blog posts describing some of the issues.

http://blogs.technet.com/b/deploymentguys/archive/2009/10/29/configuring-default-user-settings-full-update-for-windows-7-and-windows-server-2008-r2.aspx

http://blogs.technet.com/b/askcore/archive/2010/07/28/customizing-default-users-profile-using-copyprofile.aspx

How to customize the Start Screen in Windows 8+

Windows provides a limited set of interfaces to modify the Start Screen programmatically(or via script). The best solution to make a Start Screen the way you want is to manually prepare the screen in the full OS with the local Administrator account, SysPrep and then use CopyProfile to ensure that the Start Screen for the Administrator is applied to all new users. For more information see: http://technet.microsoft.com/en-us/library/jj134269.aspx
(Personally I prefer the AppsFolderLayout.Bin method in this article).

Religious Wars 

Warning: asking the following topics may produce different answers from different users. (Provided here as humor).

Sector Based Imaging vs File Based Imaging - *.vhd is sector based, *.wim is file based. MDT mostly uses *.wim files.
Fat images vs Thin Images  - See Above
Structured Driver Installation vs Chaos – http://channel9.msdn.com/Events/TechEd/NorthAmerica/2012/WCL307
Single Partition vs Multiple Partitions for Disk 0 –Don’t put data on D: drive.
What to do when things go wrong?

First off, don’t panic. Remember, Windows Deployment is a large and complex system.

If you are new to MDT and Windows deployment, now would be a good time to familiarize yourself with some of the troubleshooting tools and techniques. Michael Niehaus and Keith Garner (both former Program Managers and Developers on the MDT project) provided a good overview at TechEd 2011 here: https://www.youtube.com/watch?v=J3d6PWZyutY . The content is valid for Windows 7 and above, and Windows Server 2008 R2 and above.

If you still have problems and wish to ask the forum, please be clear and specific. If the problem is on the client machine, can you share the relevant log files? Generally we don’t recommend adding the log files to the Technet Form post, bdd.log and smsts.log files can get quite large. Instead, use a public web service like SkyDrive. Create a public share, copy the log files there, and send a link to the folder.

What Log files should I share?

If you get to the end of the Windows Deployment, and you get the red [salmon] summary screen, share the bdd.log file. Typically found in c:\windows\temp\deploymentlogs (requires elevation to see this folder).

If the bdd.log file says that there was an error in the task sequence (error 0x80040005), then the task sequencer failed, share the smsts.log file too.

If you get an error during Windows Setup, share the panther logs. See article KB927521 for more information.

The Log files are hard to read!

MDT and SCCM log files are in a proprietary ML format. Use the cmtrace.exe tool provided in System Center Configuration Manager 2012 (SCCM) to view these log files formatted. This tool is a must have for any SCCM or MDT administrator.

Future FAQ items (Help contribute)
How can I customize MDT?

What are Key/Vaule pairs in MDT (Cs.ini/database/webservice/wizard)
How to write a VBScript/Powershell Script 
How to debug scripts in MDT
How to Extend the wizard
http://channel9.msdn.com/Events/MMS/2012/CD-B412
What are the known issues of MDT 2013

How to debug/fix common problems:

Issues with partitions and other disk issues.
How to add a network driver to MDT.
Errors within Windows Setup (Panther logs).
Follow along with a full MDT OS Installation. With labels.
(Do not add any new questions to this post, they will be deleted! Create a new thread).



