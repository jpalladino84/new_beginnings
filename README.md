
Backup 1Password and SSH creds to be copied onto new machine if OSX.
Install xcode and agree to license.
Run setup.sh

TODO:
ssh-add key to new machine
include gitconfigure to use personal e-mail address and add to "rig" repo
copy gitignore global to rig and install in correct space
https://github.com/jmespath/jmespath.terminal
jenv setup
awscli setup



include splitting out of work stuff...put into S3 bucket or private repo

* for work specific setup.sh that gets pulled down from S3 or git, include:
* update virtualenvwrapper
* create virtualenvs for each requirements.txt based upon where they reside in a given directory
* move into each cloned repo and set proper git-config for username and email

