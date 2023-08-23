.PHONY: setup

OS := $(shell uname)

setup:
	# Check if OS is Linux and then move dotfiles to $HOME
ifeq ($(OS), Linux)
	cp .bashrc $(HOME)/
	cp .fzf.bash $(HOME)/
	cp .profile $(HOME)/
endif

	# Run the install_ansible.sh script
	bash install_ansible.sh

	# Execute the ansible-playbook command
	ansible-playbook ansible/dev_setup.yml
