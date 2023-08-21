.PHONY: setup

setup:
	# Move dotfiles to $HOME
	cp .bahsrc $(HOME)/
	cp .fzf.bash $(HOME)/
	cp .profile $(HOME)/

	# Run the install_ansible.sh script
	bash install_ansible.sh

	# Execute the ansible-playbook command
	ansible-playbook ansible/dev_setup.yml
