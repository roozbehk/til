In order to write the reference image back to the deployment share, you need to assign Modify permissions to the MDT Build Account (MDT_BA) for the Captures subfolder in the E:\MDTBuildLab folder

1.On MDT01, log on as `CONTOSO\Administrator`.


2.Modify the NTFS permissions for the E:\MDTBuildLab\Captures folder by running the following command in an elevated Windows PowerShell prompt:

`` icacls E:\MDTBuildLab\Captures /grant '"MDT_BA":(OI)(CI)(M)'``


https://technet.microsoft.com/en-us/itpro/windows/deploy/create-a-windows-10-reference-image
