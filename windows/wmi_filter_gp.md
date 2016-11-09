
The examples below should be familiar as a common way to apply a GPO to all Versions of Windows after 7. It would also automatically work for Windows 8 and Windows 8.1. But it will fail for Windows 10!

select * from Win32_OperatingSystem where Version >= "6.1"

Unfortunately, WMI — dumb thing that it is — executes this code by comparing strings not numbers. For non-rocket scientists, this means that Version “10” is actually lower than Version "6.0" as 1 is lower than 6. Forcing us, against our will, to change our previously working WMI filter to:

select * from Win32_OperatingSystem where Version like "10.%" or Version >="6.1"

Note that the same is also true for Windows Server 2016 as it has the same OS version number. This is why I've created this new article.

WMI Filtering is another tool to put in your active directory toolbox. Notice the order of execution of Group Policy Objects:

Policies in hierarchy are located. (L-S-D-OU)
WMI Filters are checked
Security settings are checked
Only then after everything has passed is the policy applied
With this in mind take the following steps in strict order:

Locate all policies in the user/computer’s Local, Site, Domain, and OU hierarchy
Verify that the WMI filter evaluates as TRUE
Verify that the user/computer has Read and Apply Group permissions for the GPO
This means that WMI filters are still less efficient than hierarchical linking (I said that Microsoft's Group Policy had improved. I didn't say it was perfect!) but you can definitely use filters to make decisions in a non-hierarchical Active Directory design.

Many SysAdmins don't like WMI Filtering: they reckon it’s as slow as a tortoise with a sore foot. They say queries proceed a glacial speed on slow machines. So best to test on your slowest machine in a LAB environment first. Having a hierarchical Active Directory has its good points but it can be as difficult to control as a sack of squirrels. What you give with one hand you take away with the other.

You can have a group policy that runs on a specific day of the week if that's what floats your boat. For instance:

On Mondays:

select DayOfWeek from Win32_LocalTime where DayOfWeek = 1

On the weekend:

select DayOfWeek from Win32_LocalTime where DayOfWeek > 5

During the work Week:

select DayOfWeek from Win32_LocalTime where DayOfWeek < 6

Another example is for older operating systems

select version from Win32_OperatingSystem where version < "6"

The statement will return TRUE for Windows XP, Windows Server 2003 (Sorry, but WMI isn't available for W2K).

Enabling UAC on all machines for everyone including Admins is a good idea except for SERVER-CORE machines.

Test your query with WBEMTEST which is included in the operating system of every OS that supports WMI. Then click Connect, leave it as root\cimv2, then click Query, and paste in your query as-is, then click Apply. If you get 0 objects returned that is a False, 1 object returned is a True.

Microsoft Windows Desktops

 

Any Windows Desktop OS

select * from Win32_OperatingSystem WHERE (ProductType <> "2") AND (ProductType <> "3")

Any Windows Desktop OS - 32-bit

select * from Win32_OperatingSystem WHERE ProductType = "1" AND NOT OSArchitecture = "64-bit"

Any Windows Desktop OS - 64-bit

select * from Win32_OperatingSystem WHERE ProductType = "1" AND OSArchitecture = "64-bit"

Windows XP

select * from Win32_OperatingSystem WHERE (Version like "5.1%" or Version like "5.2%") AND ProductType="1"

Windows XP - 32-bit

select * from Win32_OperatingSystem WHERE (Version like "5.1%" or Version like "5.2%") AND ProductType="1" AND NOT OSArchitecture = "64-bit"

Windows XP - 64-bit

select * from Win32_OperatingSystem WHERE (Version like "5.1%" or Version like "5.2%") AND ProductType="1" AND OSArchitecture = "64-bit"

Windows Vista

select * from Win32_OperatingSystem WHERE Version like "6.0%" AND ProductType="1"

Windows Vista - 32-bit

select * from Win32_OperatingSystem WHERE Version like "6.0%" AND ProductType="1" AND NOT OSArchitecture = "64-bit"

Windows Vista - 64-bit

select * from Win32_OperatingSystem WHERE Version like "6.0%" AND ProductType="1" AND OSArchitecture = "64-bit"

Windows 7

select * from Win32_OperatingSystem WHERE Version like "6.1%" AND ProductType="1"

Windows 7 - 32-bit

select * from Win32_OperatingSystem WHERE Version like "6.1%" AND ProductType="1" AND NOT OSArchitecture = "64-bit"

Windows 7 - 64-bit

select * from Win32_OperatingSystem WHERE Version like "6.1%" AND ProductType="1" AND OSArchitecture = "64-bit"

Windows 8

select * from Win32_OperatingSystem WHERE Version like "6.2%" AND ProductType="1"

Windows 8 - 32-bit

select * from Win32_OperatingSystem WHERE Version like "6.2%" AND ProductType="1" AND NOT OSArchitecture = "64-bit"

Windows 8 - 64-bit

select * from Win32_OperatingSystem WHERE Version like "6.2%" AND ProductType="1" AND OSArchitecture = "64-bit"

Windows 8.1

select * from Win32_OperatingSystem WHERE Version like "6.3%" AND ProductType="1"

Windows 8.1 - 32-bit

select * from Win32_OperatingSystem WHERE Version like "6.3%" AND ProductType="1" AND NOT OSArchitecture = "64-bit"

Windows 8.1 - 64-bit

select * from Win32_OperatingSystem WHERE Version like "6.3%" AND ProductType="1" AND OSArchitecture = "64-bit"

Windows 10

select * from Win32_OperatingSystem WHERE Version like "10.%" AND ProductType="1"

Windows 10 - 32-bit

select * from Win32_OperatingSystem WHERE Version like "10.%" AND ProductType="1" AND NOT OSArchitecture = "64-bit"

Windows 10 - 64-bit

select * from Win32_OperatingSystem WHERE Version like "10.%" AND ProductType="1" AND OSArchitecture = "64-Bit"

Microsoft Windows Servers

 

Any Windows Server OS

select * from Win32_OperatingSystem where (ProductType = "2") OR (ProductType = "3")

Any Windows Server OS - 32-bit

select * from Win32_OperatingSystem where (ProductType = "2") OR (ProductType = "3") AND NOT OSArchitecture = "64-bit"

Any Windows Server OS - 64-bit

select * from Win32_OperatingSystem where (ProductType = "2") OR (ProductType = "3") AND OSArchitecture = "64-bit"

Any Windows Server - Domain Controller

select * from Win32_OperatingSystem where (ProductType = "2")

Any Windows Server - Domain Controller - 32-bit

select * from Win32_OperatingSystem where (ProductType = "2") AND NOT OSArchitecture = "64-bit"

Any Windows Server - Domain Controller - 64-bit

select * from Win32_OperatingSystem where (ProductType = "2") AND OSArchitecture = "64-bit"

Any Windows Server - Non-Domain Controller

select * from Win32_OperatingSystem where (ProductType = "3")

Any Windows Server - Non- Domain Controller - 32-bit

select * from Win32_OperatingSystem where (ProductType = "3") AND NOT OSArchitecture = "64-bit"

Any Windows Server - Non-Domain Controller - 64-bit

select * from Win32_OperatingSystem where (ProductType = "3") AND OSArchitecture = "64-bit"

Windows Server 2003 - DC

select * from Win32_OperatingSystem WHERE Version like "5.2%" AND ProductType="2"

Windows Server 2003 - non-DC

select * from Win32_OperatingSystem WHERE Version like "5.2%" AND ProductType="3"

Windows Server 2003 - 32-bit - DC

select * from Win32_OperatingSystem WHERE Version like "5.2%" AND ProductType="2" AND NOT OSArchitecture = "64-bit"

Windows Server 2003 - 32-bit - non-DC

select * from Win32_OperatingSystem WHERE Version like "5.2%" AND ProductType="3" AND NOT OSArchitecture = "64-bit"

Windows Server 2003 - 64-bit - DC

select * from Win32_OperatingSystem WHERE Version like "5.2%" AND ProductType="2" AND OSArchitecture = "64-bit"

Windows Server 2003 - 64-bit - non-DC

select * from Win32_OperatingSystem WHERE Version like "5.2%" AND ProductType="3" AND OSArchitecture = "64-bit"

Windows Server 2003 R2 - DC

select * from Win32_OperatingSystem WHERE Version like "5.2.3%" AND ProductType="2"

Windows Server 2003 R2 - non-DC

select * from Win32_OperatingSystem WHERE Version like "5.2.3%" AND ProductType="3"

Windows Server 2003 R2 - 32-bit - DC

select * from Win32_OperatingSystem WHERE Version like "5.2.3%" AND ProductType="2" AND NOT OSArchitecture = "64-bit"

Windows Server 2003 R2 - 32-bit - non-DC

select * from Win32_OperatingSystem WHERE Version like "5.2.3%" AND ProductType="3" AND NOT OSArchitecture = "64-bit"

Windows Server 2003 R2 - 64-bit - DC

select * from Win32_OperatingSystem WHERE Version like "5.2.3%" AND ProductType="2" AND OSArchitecture = "64-bit"

Windows Server 2003 R2 - 64-bit - non-DC

select * from Win32_OperatingSystem WHERE Version like "5.2.3%" AND ProductType="3" AND OSArchitecture = "64-bit"

Windows Server 2008 - DC

select * from Win32_OperatingSystem WHERE Version like "6.0%" AND ProductType="2"

Windows Server 2008 – non-DC

select * from Win32_OperatingSystem WHERE Version like "6.0%" AND ProductType="3"

Windows Server 2008 - 32-bit - DC

select * from Win32_OperatingSystem WHERE Version like "6.0%" AND ProductType="2" AND NOT OSArchitecture = "64-bit"

Windows Server 2008 - 32-bit - non-DC

select * from Win32_OperatingSystem WHERE Version like "6.0%" AND ProductType="3" AND NOT OSArchitecture = "64-bit"

Windows Server 2008 - 64-bit - DC

select * from Win32_OperatingSystem WHERE Version like "6.0%" AND ProductType="2" AND OSArchitecture = "64-bit"

Windows Server 2008 - 64-bit - non-DC

select * from Win32_OperatingSystem WHERE Version like "6.0%" AND ProductType="3" AND OSArchitecture = "64-bit"

Windows Server 2008 R2 - 64-bit - DC

select * from Win32_OperatingSystem WHERE Version like "6.1%" AND ProductType="2"

Windows Server 2008 R2 - 64-bit - non-DC

select * from Win32_OperatingSystem WHERE Version like "6.1%" AND ProductType="3"

Windows Server 2012 - 64-bit - DC

select * from Win32_OperatingSystem WHERE Version like "6.2%" AND ProductType="2"

Windows Server 2012 - 64-bit - non-DC

select * from Win32_OperatingSystem WHERE Version like "6.2%" AND ProductType="3"

Windows Server 2012 R2 - 64-bit - DC

select * from Win32_OperatingSystem WHERE Version like "6.3%" AND ProductType="2"

Windows Server 2012 R2 - 64-bit - non-DC

select * from Win32_OperatingSystem WHERE Version like "6.3%" AND ProductType="3"

Windows Server 2016 - 64-bit - DC

select * from Win32_OperatingSystem WHERE Version like "10.%" AND ProductType="2"

Windows Server 2016 - 64-bit - non-DC

select * from Win32_OperatingSystem WHERE Version like "10.%" AND ProductType="3"
