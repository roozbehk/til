# Working with SSH key passphrases
# Auto-launching ssh-agent

```
sudo apt-get install keychain

```

Then add the following line to your ~/.bashrc

```eval $(keychain --q --noask --eval id_rsa)```

This will start the ssh-agent if it isn't running, connect to it if it is, load the ssh-agent environment variables into your shell, and load your ssh key.
