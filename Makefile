.PHONY: setup

setup:
	# Run the install_ansible.sh script
	./install_ansible.sh

	# Execute the ansible-playbook command
	ansible-playbook ansible/dev_setup.yml
