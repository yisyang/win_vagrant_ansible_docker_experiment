# Windows Vagrant Ansible Docker Experiment

This is a personal experiment to get a full dev environment working on local windows machine, 
using **Vagrant + Ansible + Docker**, with the hope that eventually everything done here will 
allow for a quick and complete development environment setup **on any OS** including:
- server deployment
- network configuration with port redirection
- user access setup
- git integration


## Pre-requisites

1. Vagrant
2. Virtual Box
    - Note: On access restricted machines, the default installation options may fail. Unchecking bridge mode network driver solved it me, with the following caveats:
        - Vagrant public_network option is not available
        - WiFi may not work while the VirtualBox Host-Only Adapter is enabled
3. Configure and run script
    - Make a copy of ./provisioning/vars/config-main-EXAMPLE.yml as config-main.yml, read and edit
    - Copy appropriate files (such as ssh_user_sshkey and ssh_user_gitkey) into ./provisioning/files/
    - vagrant up


## Sources

#### Ansible

- https://github.com/geerlingguy/JJG-Ansible-Windows
    - Vagrant shell provisioner for running Ansible on guest machine, as a hack to make Ansible "work on Windows"
    - license: https://github.com/geerlingguy/JJG-Ansible-Windows/blob/master/LICENSE
- https://github.com/mgcrea/ansible-web-playbooks
    - Original source of the roles used in this playbook
    - license: https://github.com/mgcrea/ansible-web-playbooks/blob/master/LICENSE.md
- https://github.com/Traackr/ansible-elasticsearch#license
    - Role for installing ElasticSearch, supports various linux distros, also supports AWS EC2
    - license: https://github.com/Traackr/ansible-elasticsearch#license

#### Docker
- TBD

## License
MIT (https://github.com/yisyang/win_vagrant_ansible_docker_experiment/blob/master/LICENSE)