First, mount the vhd using

`Mount-WindowsImage -ImagePath C:\VHDs\BigHomies.vhdx -Path C:\VHDMount -Index 1`
Then, capture it into a wim with

`New-WindowsImage -CapturePath C:\VHDMount -Name Win7Image -ImagePath C:\CapturedWIMs\Win7.wim -Description "Yet another Windows 7 Image" -Verify`

And let it do it's thing. When you are done you can unmount the vhd and discard any changes using:

`Dismount-WindowsImage -Path C:\VHDMount -Discard`
