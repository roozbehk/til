The Bootstrap.ini and CustomSettings.ini files work together. The Bootstrap.ini file is always present on the boot image and is read first. The basic purpose for Bootstrap.ini is to provide just enough information for MDT to find the CustomSettings.ini.

The CustomSettings.ini file is normally stored on the server, in the Deployment share\Control folder, but also can be stored on the media (when using offline media).

Note
The settings, or properties, that are used in the rules (CustomSettings.ini and Bootstrap.ini) are listed in the MDT documentation, in the Microsoft Deployment Toolkit Reference / Properties / Property Definition section.


https://technet.microsoft.com/en-us/itpro/windows/deploy/create-a-windows-10-reference-image
