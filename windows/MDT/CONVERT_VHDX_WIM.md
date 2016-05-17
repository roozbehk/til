Create folder `Mount` and Mount the vhdx to that folder

``Mount-WindowsImage -ImagePath M:\VMs\IMAGE_BASE_WIN10ENT.vhdx -Path M:\Mount -Index 1``

Create WIM file
``New-WindowsImage -CapturePath M:\Mount -Name Windows10EntImage M:\VMs\Win10.wim -Verify``

unmount vhdx
``Dismount-WindowsImage -Path M:\Mount -Discard``
