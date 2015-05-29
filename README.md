# Windows Vagrant Ansible Docker Experiment

This is a personal experiment to get a full dev environment working on local windows machine, 
using **Vagrant + Ansible + Docker**, with the hope that eventually everything done here will 
allow for a quick and complete development environment setup **on any OS** including:
- server deployment
- network configuration with port redirection
- user access setup
- git integration


# Pre-requisites

1. Vagrant
2. Virtual Box
	Note: On access restricted machines, the default installation options may fail. Unchecking bridge mode network driver solved it me with the "caveat" of not being able to open up VMs to the outside.


# Sources

Most of the scripts used here can be found in their original states from the following sources:

Ansible:

https://github.com/geerlingguy/JJG-Ansible-Windows

https://github.com/mgcrea/ansible-web-playbooks

https://github.com/pvillega/ansible-ec2-play

Docker:
TBD