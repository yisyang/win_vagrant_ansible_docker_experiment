#!/bin/bash
#
# Windows shell provisioner for Ansible playbooks, based on KSid's
# windows-vagrant-ansible: https://github.com/KSid/windows-vagrant-ansible
#
# @see README.md
# @author Jeff Geerling, 2014

# Uncomment if behind a proxy server.
# export {http,https,ftp}_proxy='http://username:password@proxy-host:80'

ANSIBLE_PLAYBOOK=$1
PLAYBOOK_DIR=${ANSIBLE_PLAYBOOK%/*}
if [[ $# -ge 2 ]]; then
	ANSIBLE_TAGS=$2
	ANSIBLE_TAGS_CMD=" --tags ${ANSIBLE_TAGS}"
else
	ANSIBLE_TAGS_CMD=""
fi

ROLE_REQUIREMENTS=$(find /vagrant/$PLAYBOOK_DIR -name "requirements.yml" -o -name "requirements.txt")

# If true, will re-run requirements on each provisioning, if false, will only run requirements when installing ansible
RERUN_REQUIREMENTS=false

# Make sure Ansible playbook exists.
if [[ ! -f /vagrant/$ANSIBLE_PLAYBOOK ]]; then
	echo "Cannot find Ansible playbook."
	exit 1
fi

echo "Windows machine detected, will run Ansible locally on guest machine"

# Detect various dependencies
echo "Checking dependencies.";
declare -a DEPENDENCY_LIST=('yum' 'apt-get' 'python' 'pip' 'ansible', 'git');
declare -A DEPENDENCY_EXISTS
for i in "${!DEPENDENCY_LIST[@]}"
	do
		if [[ ! -z $(which ${DEPENDENCY_LIST[$i]}) ]]; then
			DEPENDENCY_EXISTS[${DEPENDENCY_LIST[$i]}]=true
		else
			DEPENDENCY_EXISTS[${DEPENDENCY_LIST[$i]}]=false
		fi
	done

# Install git if not found, as many ansible roles used will require it
if [[ "${DEPENDENCY_EXISTS[git]}" != true ]]; then
	if [[ "${DEPENDENCY_EXISTS[yum]}" == true ]]; then
		yum install -y git
	elif [[ "${DEPENDENCY_EXISTS[apt-get]}" == true ]]; then
		apt-get install -y git
	else
		echo "Neither yum nor apt-get are available."
		exit 1;
	fi
fi

# Install Ansible if not found
if [[ "${DEPENDENCY_EXISTS[ansible]}" != true ]]; then

	# Install python if not found
	if [[ "${DEPENDENCY_EXISTS[python]}" != true ]]; then
		echo "Installing python"
		if [[ "${DEPENDENCY_EXISTS[yum]}" == true ]]; then
			yum install -y python python-devel
		elif [[ "${DEPENDENCY_EXISTS[apt-get]}" == true ]]; then
			apt-get install -y python python-dev
		else
			echo "Neither yum nor apt-get are available."
			exit 1;
		fi
	fi

	# Install pip using instructions from https://pip.pypa.io/en/stable/installing.html#install-pip
	if [[ "${DEPENDENCY_EXISTS[pip]}" != true ]]; then
		echo "Installing pip, setuptools, wheel"
		wget https://bootstrap.pypa.io/get-pip.py
		sudo python get-pip.py && rm -f get-pip.py
	fi

	# Ansible install will also install required modules
	echo "Installing Ansible"
	sudo pip install ansible

	RUN_REQUIREMENTS=true
else
	echo "Ansible is available"

	RUN_REQUIREMENTS=$RERUN_REQUIREMENTS
fi

# Install Ansible roles from requirements file, if available.
if [[ -f "$ROLE_REQUIREMENTS" ]] && [[ $RUN_REQUIREMENTS == true ]]; then
	echo "Installing Ansible requirements"
	echo "Found Ansible role file at $ROLE_REQUIREMENTS"
	sudo ansible-galaxy install -r "${ROLE_REQUIREMENTS}"
fi

# Run the playbook.
echo "Running Ansible provisioner defined in Vagrantfile."
echo "ansible-playbook -i 'localhost,' /vagrant/${ANSIBLE_PLAYBOOK}${ANSIBLE_TAGS_CMD} --extra-vars \"is_windows=true\" --connection=local"
ansible-playbook -i 'localhost,' /vagrant/${ANSIBLE_PLAYBOOK}${ANSIBLE_TAGS_CMD} --extra-vars "is_windows=true" --connection=local
