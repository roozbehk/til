
```
#!/usr/bin/env bash
#Replace .profile with .bashrc if required
source ~/.profile
if [ -z "$VAR" ]; then # only checks if VAR is set, regardless of its value
    echo "export VAR=value" >> ~/.profile
fi
#other env variables and profile stuff here
```
