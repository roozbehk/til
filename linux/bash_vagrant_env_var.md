
```
#!/usr/bin/env bash
#Replace .profile with .bashrc if required
source ~/.profile
if [ -z "$VAGRANT_DEFAULT_PROVIDER" ]; then # only checks if VAR is set, regardless of its value
    echo "export VAGRANT_DEFAULT_PROVIDER=vmware_fusion" >> ~/.profile
fi
#other env variables and profile stuff here
```
